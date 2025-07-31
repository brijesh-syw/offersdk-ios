//
//  OfferVC.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 28/06/24.
//

import UIKit
import SDWebImage

final public class OfferVC: UIViewController {
    
    //MARK: - Variables
    var config: OfferConfig!
    private var session: APIClient!
    
    var offerRespModel : OfferRespModel?
    var arrData : [CellModel] = []
    var arrOffer : [OfferModel] = []
    
   
    
    //MARK: - Outlets
    @IBOutlet weak var collectionOffer: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!    
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var tblOffer: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
       
    @IBOutlet weak var vwClose: UIView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
       
        self.collectionOffer.register(UINib(nibName: "OfferCollectionCell", bundle: getCurrentBundle(self)), forCellWithReuseIdentifier: "OfferCollectionCell")
        self.tblOffer.register(UINib(nibName: "OfferTableCell", bundle: getCurrentBundle(self)), forCellReuseIdentifier: "OfferTableCell")

        let bundle = Bundle(for: type(of: self))
        self.collectionCategory.register(UINib(nibName: "OfferCategoryCell", bundle: bundle), forCellWithReuseIdentifier: "OfferCategoryCell")
        self.collectionOffer.register(UINib(nibName: "OfferGridCollectionCell", bundle: bundle), forCellWithReuseIdentifier: "OfferGridCollectionCell")
                
        
//        getSetupData()
        configureSDWebImage()
        
        tblOffer.isHidden = true
        collectionOffer.isHidden = false
        
    }
    
    func getData() {
        guard config != nil else { fatalError("Config is not set. Please use setConfig.") }
        session = APIClient(with: config)
        
        activityIndicator.startAnimating()
        session.getOffer { resp in
            self.offerRespModel = resp
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.setupData()

            }
        } completionWithError: { errorMsg in
            print(errorMsg ?? "")
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.showToast(message: errorMsg ?? "")
            }
        }
    }
    
    func configureSDWebImage() {
        
        let imageDownloader = SDWebImageDownloader.shared
        imageDownloader.setValue("application/json", forHTTPHeaderField: "Content-Type")
        imageDownloader.setValue("application/json", forHTTPHeaderField: "Accept")
        imageDownloader.setValue(config.organization, forHTTPHeaderField: "organization")
        imageDownloader.setValue(config.merchantId, forHTTPHeaderField: "client_id")
        imageDownloader.setValue("telluride", forHTTPHeaderField: "platform")
//        imageDownloader.setValue(config.refId, forHTTPHeaderField: "refId")
        
    }
    
    func setupData() {
        //
        let arr = offerRespModel?.contentOffers ?? []
        
        
        
        let registered  = arr.filter { obj in
            return obj.isRegisteredOffer == true
        }.sorted(by: { obj1, obj2 in
            let obj1EndDate = Date().getDateFromString(dt: obj1.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
            let obj2EndDate = Date().getDateFromString(dt: obj2.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
            
//            if(obj1EndDate == obj2EndDate){
//                return (obj1.contentId ?? "").getInt < (obj2.contentId ?? "").getInt
//            }
            return obj1EndDate < obj2EndDate
        })
        
        let unRegistered  = arr.filter { obj in
            return obj.isRegisteredOffer == false
        }.sorted(by: { obj1, obj2 in
            let obj1EndDate = Date().getDateFromString(dt: obj1.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
            let obj2EndDate = Date().getDateFromString(dt: obj2.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
//            if(obj1EndDate == obj2EndDate){
//                return (obj1.contentId ?? "").getInt < (obj2.contentId ?? "").getInt
//            }
            return obj1EndDate < obj2EndDate
        })
        
        
        
        
        arrOffer = []
        
        arrOffer.append(contentsOf: registered)
        arrOffer.append(contentsOf: unRegistered)
        
        
        
//        arrOffer = offerRespModel?.offers?.getAvailableOffer() ?? []
        self.collectionOffer.reloadData()
//        self.tblOffer.reloadData()
    }
    
    func updateData(model:CellModel) {
//        if model.cellType == .FilterAvailable {
//            arrOffer = offerRespModel?.offers?.getAvailableOffer() ?? []
//        }
//        else if model.cellType == .FilterRedeemed {
//            arrOffer = offerRespModel?.offers?.getRedeemedOffer() ?? []
//        }
//        else if model.cellType == .FilterExpired {
//            arrOffer = offerRespModel?.offers?.getExpiredOffer() ?? []
//        }
//
//        self.collectionOffer.reloadData()
//        self.tblOffer.reloadData()
    }
    
//    func getSetupData() {
//        arrData.append(CellModel.getModel(text: "Available", type: CellType.FilterAvailable, isSelected: true))
//        arrData.append(CellModel.getModel(text: "Redeemed", type: CellType.FilterRedeemed, isSelected: false))
//        arrData.append(CellModel.getModel(text: "Expired", type: CellType.FilterExpired, isSelected: false))
//
//        collectionCategory.reloadData()
//    }
    
    //MARK: - IBActions
    @IBAction func btnClose_Clicked(_ sender: UIButton) {
        
        if (self.presentingViewController != nil) {
            self.dismiss(animated: true)
        }
        else if tabBarController?.presentingViewController is UITabBarController {
            //
        }
        else if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func btnFilter_Click(_ sender: UIButton) {
        let vc = FilterVC(nibName: "FilterVC", bundle: getCurrentBundle(self))
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func segmentControl_Changed(_ sender: UISegmentedControl) {
        if(segmentControl.selectedSegmentIndex == 0) {
            tblOffer.isHidden = true
            collectionOffer.isHidden = false
        }
        else {
            tblOffer.isHidden = false
            collectionOffer.isHidden = true
        }
    }
}

extension OfferVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionOffer) {
//            return offerRespModel?.offers?.offerExtended?.count ?? 0
            return arrOffer.count
        }
        else if(collectionView == collectionCategory) {
            return arrData.count
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionOffer) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferGridCollectionCell", for: indexPath) as? OfferGridCollectionCell
                        
            cell?.setData(model: arrOffer[indexPath.row], config: config)
            cell?.onClickRegister = {
                self.registerOffer(index: indexPath.row, model: self.arrOffer[indexPath.row])
            }
            
            return cell ?? UICollectionViewCell()
        }
        else if(collectionView == collectionCategory) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCategoryCell", for: indexPath) as? OfferCategoryCell
            cell?.setData(model: arrData[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == collectionOffer) {
            if (UIDevice.current.userInterfaceIdiom == .pad) {
                //24
                let width = ((collectionView.frame.size.width) / 4) - 8
                return CGSize(width: width, height: 250)
            }
            else {
                let width = ((collectionView.frame.size.width) / 2) - 4
                return CGSize(width: width, height: 250)
            }
            
        }
        else if(collectionView == collectionCategory) {
            let width = ((collectionCategory.frame.size.width) / 3) - 8
            return CGSize(width: width, height: collectionCategory.frame.size.height)
        }
        return CGSize(width: 0, height: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if(collectionView == collectionCategory) {
//            arrData[indexPath.row].isSelected = !arrData[indexPath.row].isSelected
//            collectionCategory.reloadItems(at: [indexPath])
//        }
        
        if(collectionView == collectionOffer) {
            let vc = OfferContentVC(nibName: "OfferContentVC", bundle: getCurrentBundle(self))
            vc.offerModel = arrOffer[indexPath.row]
            vc.environment = config.environment
            
//            vc.isModalInPresentation = true
            vc.modalPresentationStyle = .custom
            
            self.present(vc, animated: false)
        }
        else if(collectionView == collectionCategory) {
            
            arrData = arrData.map({ model in
                model.isSelected = false
                return model
            })
            arrData[indexPath.row].isSelected = true
            
            collectionCategory.reloadData()
            updateData(model: arrData[indexPath.row])
        }
    }
}

extension OfferVC : UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffer.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferTableCell") as? OfferTableCell
        cell?.setData(model: arrOffer[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension OfferVC {
    
    func registerOffer(index:Int, model: OfferModel) {
        
        activityIndicator.startAnimating()
        session.registerOffer(model: model) { successMsg in
            print("Success : \(successMsg ?? "")")
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.arrOffer[index].isRegister = "Y"
                self.collectionOffer.reloadData()
            }
        } completionWithError: { errorMsg in
            print("Failure : \(errorMsg ?? "")")
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.showToast(message: errorMsg ?? "Something went wrong!!!")
            }
        }
    }
}
