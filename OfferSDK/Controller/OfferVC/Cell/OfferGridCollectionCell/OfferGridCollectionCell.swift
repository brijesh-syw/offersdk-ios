//
//  OfferGridCollectionCell.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 04/09/24.
//

import UIKit

class OfferGridCollectionCell: UICollectionViewCell {
    
    var onClickRegister:(()->())?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblHeadline: UILabel!
//    @IBOutlet weak var lblBodyline: UILabel!
    @IBOutlet weak var lblExpiry: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var vwExpireSoon: UIView!
    @IBOutlet weak var imgBrand: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblExpireSoonCaption: UILabel!
    @IBOutlet weak var vwActivated: UIView!
    @IBOutlet weak var stackExpiry: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imgView.roundCorners([.topLeft,.topRight], radius: 8)
        
//        vwBg.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
//        vwBg.layer.borderColor = UIColor.red.withAlphaComponent(0.8).cgColor
        
        vwBg.setCornerRadius(radius: 8)
        vwBg.dropShadow()
        
        vwExpireSoon.roundCorners([.bottomLeft,.topRight], radius: 8)
        
//        vwBg.applyCardShadow()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgView.roundCorners([.topLeft, .topRight], radius: 8)
        imgView.clipsToBounds = true
        imgBrand.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblHeadline.attributedText = nil
        lblHeadline.text = nil
        imgView.image = nil
    }
        
    func setData(model: OfferModel, config: OfferConfig) {
        let bundle = getCurrentBundle(self)
        
                
        lblBrandName.text = model.brandName ?? " "
        DispatchQueue.main.async {
            self.lblHeadline.setHTMLStringToLabel(text: model.headline1 ?? "", align: .left)
            self.lblHeadline.numberOfLines = 2
        }
        
        if let brandLogo = model.brandLogo, brandLogo.count > 0 {
            imgBrand.isHidden = false
            imgBrand.os_setImage(with: URL(string: brandLogo))
        }
        else {
            imgBrand.isHidden = true
        }
        
        
        imgView.os_setImage(with: URL(string: model.getImageURL(env: config.environment)), placeholder: UIImage(named: "placeholder.png", in: bundle, with: .none))
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
        
        if model.isRegisteredOffer {
            vwBg.layer.borderColor = UIColor(rgb: 0x4ADD80).cgColor
            vwBg.layer.borderWidth = 1
        }
        else if model.isStaticOffer ?? false {
            vwBg.layer.borderColor = UIColor(rgb: 0xBFC8D4).cgColor
            vwBg.layer.borderWidth = 1
        }
        else {
            vwBg.layer.borderColor = UIColor(rgb: 0xF3F4F6).cgColor
            vwBg.layer.borderWidth = 1
        }
        
        vwExpireSoon.isHidden = true
        
        
        if model.isStaticOffer ?? false {
//            imgView.alpha = 0.7
//            vwBg.addDashedBorder(cornerRadius: 8)
            vwActivated.isHidden = false
            stackExpiry.isHidden = true
            
            vwBg.backgroundColor = UIColor(rgb: 0xF7F7F7)
        }
        else {
//            imgView.alpha = 1
//            vwBg.removeDashBorder()
            
            vwBg.backgroundColor = .white
            vwActivated.isHidden = true
            stackExpiry.isHidden = false
            
            lblExpireSoonCaption.isHidden = !model.isExpireSoon
        }
        
        
        
//        if model.isExpireSoon {
//            vwExpireSoon.isHidden = false
//            vwBg.layer.borderColor = UIColor.red.withAlphaComponent(0.8).cgColor
//        }
//        else {
//            vwExpireSoon.isHidden = true
//            if model.isRegisteredOffer {
//                vwBg.layer.borderColor = UIColor(rgb: 0x4ADD80).cgColor
//            }
//            else {
//                vwBg.layer.borderColor = UIColor(rgb: 0xF3F4F6).cgColor
//            }
//        }
    }
    
    
    @IBAction func btnAdd_Clicked(_ sender: UIButton) {
        onClickRegister?()
    }
    
}
