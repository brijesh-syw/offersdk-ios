//
//  OfferGridCollectionCell.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 04/09/24.
//

import UIKit
private import SDWebImage

class OfferGridCollectionCell: UICollectionViewCell {
    
    var onClickRegister:(()->())?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var lblBodyline: UILabel!
    @IBOutlet weak var lblExpiry: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var vwExpireSoon: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imgView.roundCorners([.topLeft,.topRight], radius: 8)
        
//        vwBg.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
//        vwBg.layer.borderColor = UIColor.red.withAlphaComponent(0.8).cgColor
        vwBg.layer.borderWidth = 1
        vwBg.setCornerRadius(radius: 8)
        vwBg.dropShadow()
        
        vwExpireSoon.roundCorners([.bottomLeft,.topRight], radius: 8)
        
//        vwBg.applyCardShadow()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgView.roundCorners([.topLeft, .topRight], radius: 8)
        imgView.clipsToBounds = true
    }
    
    
//    func setData(index:Int, img:String, headline: String, bodyline:String, expiry:String) {
//        let bundle = getCurrentBundle(self)
//        imgView.image = UIImage(named: img , in: bundle, with: .none)
//        lblHeadline.text = headline
//        lblBodyline.text = bodyline
//        lblExpiry.text = expiry
//
//        if(((index+1) % 3) == 0) {
//            btnAdd.setImage(UIImage(named: "greenTick.png", in: bundle, with: .none), for: .normal)
//        }
//        else {
//            btnAdd.setImage(UIImage(named: "plus_round.png", in: bundle, with: .none), for: .normal)
//        }
//    }
    
    func setData(model: OfferModel, config: OfferConfig) {
        let bundle = getCurrentBundle(self)
        
//        lblHeadline.setHTMLStringToLabel(text: model.headline1 ?? "", align: .center)
//        lblHeadline.setHTMLStringToLabel(text: "<p>Light up your cart with festive discounts.</p>", align: .center)
        //lblBodyline.setHTMLStringToLabel(text: model.bodyline1 ?? "", align: .center)
        
        DispatchQueue.main.async {
            self.lblHeadline.setHTMLStringToLabel(text: model.headline1 ?? "", align: .center)
            self.lblBodyline.setHTMLStringToLabel(text: model.bodyline1 ?? "", align: .center)
        }
        
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgView.sd_setImage(with: URL(string: model.getImageURL(env: config.environment)), placeholderImage: UIImage(named: "placeholder.png", in: bundle, with: .none))
        lblExpiry.text = model.getOfferEndCaption()
        
        if model.isShowAddButton() {
            btnAdd.isHidden = false
            if model.isRegisteredOffer {
                btnAdd.setImage(UIImage(named: "greenTick.png", in: bundle, with: .none), for: .normal)
                btnAdd.isUserInteractionEnabled = false
            }
            else {
                btnAdd.setImage(UIImage(named: "plus_round.png", in: bundle, with: .none), for: .normal)
                btnAdd.isUserInteractionEnabled = true
            }
        }
        else {
            btnAdd.isHidden = true
        }
        
        
        if model.isExpireSoon {
            vwExpireSoon.isHidden = false
            vwBg.layer.borderColor = UIColor.red.withAlphaComponent(0.8).cgColor
        }
        else {
            vwExpireSoon.isHidden = true
            if model.isRegisteredOffer {
                vwBg.layer.borderColor = UIColor(rgb: 0x4ADD80).cgColor
            }
            else {
                vwBg.layer.borderColor = UIColor(rgb: 0xF3F4F6).cgColor
            }
        }
    }
    
    
    @IBAction func btnAdd_Clicked(_ sender: UIButton) {
        onClickRegister?()
    }
    
}
