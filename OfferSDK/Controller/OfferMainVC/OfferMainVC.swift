//
//  OfferMainVC.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 26/08/24.
//

import UIKit
//import SDWebImage

final public class OfferMainVC: UIViewController {
    
    //MARK: - Variables
    var offerRespModel : OfferRespModel?
    var arrOffer : [OfferModel] = []
    
    //MARK: - Outlets
    @IBOutlet weak var tblOffer: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.tblOffer.register(UINib(nibName: "OfferMainTableCell", bundle: getCurrentBundle(self)), forCellReuseIdentifier: "OfferMainTableCell")
        getData()
    }
    
    func getData() {
//        activityIndicator.startAnimating()
//        APIClient().getOffer { resp in
//            self.offerRespModel = resp
//            DispatchQueue.main.async {
//                self.activityIndicator.stopAnimating()
//                self.setupData()
//                
//            }
//        } completionWithError: { errorMsg in
//            print(errorMsg ?? "")
//            DispatchQueue.main.async {
//                self.activityIndicator.stopAnimating()
//            }
//        }
    }
    
    func setupData() {
        //
        arrOffer = offerRespModel?.contentOffers ?? []
//        arrOffer = offerRespModel?.offers?.getAvailableOffer() ?? []
        self.tblOffer.reloadData()
    }

}


extension OfferMainVC : UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffer.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferMainTableCell") as? OfferMainTableCell
        cell?.setData(model: arrOffer[indexPath.row])
//        cell?.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
//        cell?.imgView.sd_setImage(with: URL(string: "https://sample-videos.com/img/Sample-jpg-image-1mb.jpg"))
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OfferContentVC(nibName: "OfferContentVC", bundle: getCurrentBundle(self))
        vc.offerModel = arrOffer[indexPath.row]
        self.present(vc, animated: true)
    }
}
