//
//  OfferVC.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 28/06/24.
//

import UIKit
private import SDWebImage

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
    
    @IBOutlet weak var vwCategory: UIView!
    
    @IBOutlet weak var vwClose: UIView!
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblHeaderBadge: UILabel!
    @IBOutlet weak var vwHeaderBadge: UIView!
    @IBOutlet weak var lblBodyText: UILabel!
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var vwHeader: UIView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        vwCategory.isHidden = true
        getData()
        
       
//        self.collectionOffer.register(UINib(nibName: "OfferCollectionCell", bundle: getCurrentBundle(self)), forCellWithReuseIdentifier: "OfferCollectionCell")
//        self.tblOffer.register(UINib(nibName: "OfferTableCell", bundle: getCurrentBundle(self)), forCellReuseIdentifier: "OfferTableCell")

        let bundle = Bundle(for: type(of: self))
        self.collectionCategory.register(UINib(nibName: "OfferCategoryCell", bundle: bundle), forCellWithReuseIdentifier: "OfferCategoryCell")
        self.collectionOffer.register(UINib(nibName: "OfferGridCollectionCell", bundle: bundle), forCellWithReuseIdentifier: "OfferGridCollectionCell")
                
        configureSDWebImage()
        
        tblOffer.isHidden = true
        collectionOffer.isHidden = false
        
        vwCategory.layer.borderColor = ThemeSettings.shared.colorSetting.primaryColor.withAlphaComponent(0.3).cgColor
        vwCategory.layer.borderWidth = 1
        
        
    }
    
//    public override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        vwHeaderBadge.setGradientBackground(colorTop: UIColor(rgb: 0xfbbf24), colorBottom: UIColor(rgb: 0xf59e0b))
//    }
    
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
            debugPrint(errorMsg ?? "")
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
        
        lblHeaderTitle.text = offerRespModel?.offerBannerDetails?.header?.title ?? ""
        lblHeaderBadge.text = offerRespModel?.offerBannerDetails?.header?.badge ?? ""
        lblBodyText.text = offerRespModel?.offerBannerDetails?.body?.text ?? ""
        lblBodyText.textColor = ThemeSettings.shared.colorSetting.primaryColor.withAlphaComponent(0.8)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.vwHeaderBadge.setGradientBackground(colorTop: UIColor(rgb: 0xfbbf24), colorBottom: UIColor(rgb: 0xf59e0b))
            self.vwHeaderBadge.dropShadow()
        })
        
        
        
        getSetupData()
        
//        let arr = offerRespModel?.contentOffers ?? []
//
//        
//        let registered  = arr.filter { obj in
//            return obj.isRegisteredOffer == true
//        }.sorted(by: { obj1, obj2 in
//            let obj1EndDate = Date().getDateFromString(dt: obj1.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
//            let obj2EndDate = Date().getDateFromString(dt: obj2.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
//            
////            if(obj1EndDate == obj2EndDate){
////                return (obj1.contentId ?? "").getInt < (obj2.contentId ?? "").getInt
////            }
//            return obj1EndDate < obj2EndDate
//        })
//        
//        let unRegistered  = arr.filter { obj in
//            return obj.isRegisteredOffer == false
//        }.sorted(by: { obj1, obj2 in
//            let obj1EndDate = Date().getDateFromString(dt: obj1.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
//            let obj2EndDate = Date().getDateFromString(dt: obj2.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
////            if(obj1EndDate == obj2EndDate){
////                return (obj1.contentId ?? "").getInt < (obj2.contentId ?? "").getInt
////            }
//            return obj1EndDate < obj2EndDate
//        })
//        
//        
//        
//        
//        arrOffer = []
//        
//        arrOffer.append(contentsOf: registered)
//        arrOffer.append(contentsOf: unRegistered)
//        
//        
//        self.collectionOffer.reloadData()
//        self.tblOffer.reloadData()
    }
    
    
    
    
    func updateData(model:CellModel) {
//
        if model.cellType == .FilterAvailable {
            arrOffer = offerRespModel?.getAvailableOffers() ?? []
        }
        else if model.cellType == .FilterAdded {
            arrOffer = offerRespModel?.getAddedOffers() ?? []
        }
        else if model.cellType == .FilterExpiringSoon {
            arrOffer = offerRespModel?.getExpiringSoonOffers() ?? []
        }
        self.collectionOffer.reloadData()
//        self.tblOffer.reloadData()
    }
    
    func getSetupData(isAddedNew:Bool = false) {
        if isAddedNew {
            let addedArr = offerRespModel?.getAddedOffers()
            arrData = arrData.map({ model in
                let tempModel = model
                if tempModel.cellType == .FilterAdded {
                    tempModel.text = "Added (\(addedArr?.count ?? 0))"
                }
                return tempModel
            })
            collectionCategory.reloadData()
        
        }
        else {
            arrData.removeAll()
            let availableArr = offerRespModel?.getAvailableOffers()
            let available = CellModel.getModel(text: "Available (\(availableArr?.count ?? 0))", type: CellType.FilterAvailable, isSelected: true)
            arrData.append(available)
            updateData(model: available)
            
            let addedArr = offerRespModel?.getAddedOffers()
            arrData.append(CellModel.getModel(text: "Added (\(addedArr?.count ?? 0))", type: CellType.FilterAdded, isSelected: false))
            
            let expiringSoonArr = offerRespModel?.getExpiringSoonOffers()
            arrData.append(CellModel.getModel(text: "Expiring Soon (\(expiringSoonArr?.count ?? 0))", type: CellType.FilterExpiringSoon, isSelected: false))

            collectionCategory.reloadData()
            
            
            if (availableArr?.count ?? 0) > 0 {
                //
                vwHeader.isHidden = false
                vwCategory.isHidden = false
                lblNoData.isHidden = true
            }
            else {
                vwHeader.isHidden = true
                vwCategory.isHidden = true
                lblNoData.isHidden = false
            }
        }
        
    }
    
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
            let model = arrOffer[indexPath.row]
                        
            cell?.setData(model: model, config: config)
            cell?.onClickRegister = {
                self.registerOffer(index: indexPath.row, model: model)
            }
            
            return cell ?? UICollectionViewCell()
        }
        else if(collectionView == collectionCategory) {
            let cell = collectionCategory.dequeueReusableCell(withReuseIdentifier: "OfferCategoryCell", for: indexPath) as? OfferCategoryCell
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
                return CGSize(width: width, height: 222)
            }
            else {
                let width = ((collectionView.frame.size.width) / 2) - 4
                return CGSize(width: width, height: 222)
            }
            
        }
        else if(collectionView == collectionCategory) {
            
            let text = arrData[indexPath.item].text ?? ""
            let font = UIFont.systemFont(ofSize: 16, weight: .medium)

            let width = text.size(withAttributes: [.font: font]).width + 14
            
//            let width = ((collectionCategory.frame.size.width) / 4)
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
            let vc = OfferContent2VC(nibName: "OfferContent2VC", bundle: getCurrentBundle(self))
            vc.offerModel = arrOffer[indexPath.row]
            vc.config = config
            
            vc.onRegisterOffer = { offerModel in
                self.updateOffer(index: indexPath.row, model: offerModel)
            }
            
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
            debugPrint("Index : \(index)")
            debugPrint("Success : \(successMsg ?? "")")
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.updateOffer(index: index, model: model)
                
            }
        } completionWithError: { errorMsg in
            debugPrint("Index : \(index)")
            debugPrint("Failure : \(errorMsg ?? "")")
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.showToast(message: errorMsg ?? "Something went wrong!!!")
            }
        }
    }
    
    
    func updateOffer(index:Int, model: OfferModel) {
        var offers = self.offerRespModel?.contentOffers ?? []
        self.arrOffer[index].isRegister = "Y"

        offers = offers.map { obj in
            var offer = obj
            if offer.contentId == model.contentId {
                offer.isRegister = "Y"
            }
            return offer
        }

        self.offerRespModel?.contentOffers = offers
        
        self.getSetupData(isAddedNew: true)
        UIView.performWithoutAnimation {
            self.collectionOffer.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
}

