//
//  OfferContentVC.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 27/08/24.
//

import UIKit
import SDWebImage

class OfferContentVC: UIViewController {
    
    var offerModel:OfferModel?
    var environment: OfferEnvironment?
    
    
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var lblDesclaimer: UILabel!
    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var lblBodyLine: UILabel!
    @IBOutlet weak var btnGotoWebsite: UIButton!
    @IBOutlet weak var btnGotoWebsiteHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwContent.setCornerRadius(radius: 16)

        let bundle = getCurrentBundle(self)
        imgClose.image = UIImage(named: "close.png", in: bundle, with: .none)?.withRenderingMode(.alwaysTemplate)
        setupData()
            
    }
    
    func setupData() {
        if let model = offerModel {
            
//            lblName.text = model.offerName ?? ""
            
//            let content = model.getContent()
            lblHeadline.setHTMLStringToLabel(text: model.headline1 ?? "", align: .center)
            lblBodyLine.setHTMLStringToLabel(text: model.bodyline1 ?? "", align: .center)
            lblDesclaimer.text = model.disclaimerLegalCopy ?? ""
            imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgView.sd_setImage(with: URL(string: model.getImageURL(env: environment ?? OfferEnvironment.prod)), placeholderImage: UIImage(named: "placeholder.png", in: getCurrentBundle(self), with: .none))
            
            if (model.callToActionURL?.count ?? 0) > 0 {
                btnGotoWebsite.isHidden = false
                btnGotoWebsiteHeight.constant = 40
            }
            else {
                btnGotoWebsite.isHidden = true
                btnGotoWebsiteHeight.constant = 0
            }

        }
    }

    @IBAction func btnGotoWebsite_Clicked(_ sender: UIButton) {
        guard let url = URL(string: offerModel?.callToActionURL ?? "") else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    

    @IBAction func btnClose_Clicked(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
}
