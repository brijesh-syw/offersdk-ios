//
//  OfferContent2VC.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh on 18/02/26.
//

import UIKit
private import SDWebImage

class OfferContent2VC: UIViewController {
    
    var offerModel:OfferModel?
    var environment: OfferEnvironment?
    
    
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var lblDesclaimer: UILabel!
    @IBOutlet weak var lblHeadline: UILabel!
    
    @IBOutlet weak var imgBrandLogo: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var verticalHeaderStack: UIStackView!
    
    @IBOutlet weak var lblExpiry: UILabel!
    @IBOutlet weak var lblHeadline2: UILabel!
    @IBOutlet weak var lblHeadline3: UILabel!
    @IBOutlet weak var lblHeadline4: UILabel!
    @IBOutlet weak var lblBodyLine: UILabel!
    @IBOutlet weak var btnGotoWebsite: UIButton!
    @IBOutlet weak var btnGotoWebsiteHeight: NSLayoutConstraint!
    
    @IBOutlet weak var vwBody: UIView!
    @IBOutlet weak var vwDisclaimer: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackDetail: UIStackView!
    
    @IBOutlet weak var vwOfferAdded: UIView!
    
    @IBOutlet weak var scrollHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackBrandDetail: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwContent.setCornerRadius(radius: 16)
        self.vwContent.isHidden = true

        let bundle = getCurrentBundle(self)
        imgView.clipsToBounds = true
        imgBrandLogo.clipsToBounds = true
        
        imgClose.image = UIImage(named: "close.png", in: bundle, with: .none)?.withRenderingMode(.alwaysTemplate)
        setupData()
        
        
        vwOfferAdded.cornerBorder(width: 1, color: UIColor(rgb: 0xBBF7D0))
        
        vwBody.cornerBorder(width: 1, color: UIColor(rgb: 0xE5E7EB))
        vwDisclaimer.cornerBorder(width: 1, color: UIColor(rgb: 0xE5E7EB))
        
    }
    
    func setupData() {
        if let model = offerModel {
            
//            lblName.text = model.offerName ?? ""
            
//            let content = model.getContent()
            
            vwOfferAdded.isHidden = !model.isRegisteredOffer
            
            if ((model.brandLogo?.count ?? 0) > 0 || (model.brandName?.count ?? 0) > 0) {
                if let brandLogo = model.brandLogo, brandLogo.count > 0 {
                    imgBrandLogo.isHidden = false
                    imgBrandLogo.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    imgBrandLogo.sd_setImage(with: URL(string: brandLogo))
                }
                else {
                    imgBrandLogo.isHidden = true
                }
                lblBrandName.text = model.brandName ?? ""
                stackBrandDetail.isHidden = false
            }
            else {
                stackBrandDetail.isHidden = true
            }
            
            
            lblExpiry.text = model.getOfferEndCaption()
            lblHeadline.setHTMLStringToLabel(text: model.headline1 ?? "", align: .left)
            
//            lblHeadline2.setHTMLStringToLabel(text: model.getWholeHeadline(isSkipFirst: true), align: .left)
            lblHeadline2.setHTMLStringToLabel(text: model.headline2 ?? "", align: .left)
            lblHeadline3.setHTMLStringToLabel(text: model.headline3 ?? "", align: .left)
            lblHeadline4.setHTMLStringToLabel(text: model.headline4 ?? "", align: .left)
//            lblHeadline3.isHidden = true
//            lblHeadline4.isHidden = true
            
            
            let bodyLine = model.getWholeBodyline()
            if bodyLine.count > 0 {
                lblBodyLine.setHTMLStringToLabel(text: bodyLine, align: .left)
                vwBody.isHidden = false
            }
            else {
                vwBody.isHidden = true
            }
            
            if let disclaimerLegalCopy = model.disclaimerLegalCopy, disclaimerLegalCopy.count > 0 {
                lblDesclaimer.text = model.disclaimerLegalCopy ?? ""
                vwDisclaimer.isHidden = false
            }
            else {
                vwDisclaimer.isHidden = true
            }
            
            
            imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgView.sd_setImage(with: URL(string: model.getImageURL(env: environment ?? OfferEnvironment.prod)), placeholderImage: UIImage(named: "placeholder.png", in: getCurrentBundle(self), with: .none))
                        
            let attributes: [NSAttributedString.Key: Any] = [
                .font: ThemeSettings.shared.fontSetting.mediumFont.withSize(16),
                .foregroundColor: UIColor.white
            ]
            
            var config = btnGotoWebsite.configuration
            
            config?.attributedTitle = AttributedString(
                NSAttributedString(
                    string: model.getButtonText(),
                    attributes: attributes
                )
            )
            
            btnGotoWebsite.configuration = config
            
            if (model.callToActionURL?.count ?? 0) > 0 {
                btnGotoWebsite.isHidden = false
                btnGotoWebsiteHeight.constant = 40
            }
            else {
                btnGotoWebsite.isHidden = true
                btnGotoWebsiteHeight.constant = 0
            }
            
//            vwBody.dropShadow()
//            vwDisclaimer.dropShadow()
            
           
            

            
            
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                
                let contentHeight = self.scrollView.contentSize.height
                let maxHeight = self.view.frame.height * 0.775
                let finalHeight = min(contentHeight, maxHeight)
                

                self.scrollHeightConstraint.constant = finalHeight
                self.scrollView.isScrollEnabled = contentHeight > maxHeight
                
                self.vwContent.center.y += self.vwContent.bounds.height
                UIView.animate(withDuration: 0.6, delay: 0.2, options: [.curveEaseIn],
                               animations: {
                    self.vwContent.center.y -= self.vwContent.bounds.height
                    self.vwContent.isHidden = false
//                    self.vwContent.layoutIfNeeded()
                }, completion: nil)
                
            })
            
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
