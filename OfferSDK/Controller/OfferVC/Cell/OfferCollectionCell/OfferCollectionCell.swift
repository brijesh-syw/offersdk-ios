//
//  OfferCollectionCell.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 28/06/24.
//

import UIKit

class OfferCollectionCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblOfferName: UILabel!
    @IBOutlet weak var btnRedeem: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var vwMainExpired: UIView!
    @IBOutlet weak var vwExpired: UIView!
    
    
    //MARK: - View's Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnRedeem.cornerRadius(8)
//        viewBG.cornerBorder(width: 1, color: .lightGray)
        viewBG.cornerRadius(8)
        vwExpired.cornerRadius(15)
//        viewBG.cornerBorder(width: 1, color: .red)
    }
    
    
    func setData(model: OfferModel) {
//        lblOfferName.text = model.offerName ?? "-"
//        lblDesc.text = model.description ?? "-"
//        lblExpireDate.text = model.getExpiredDate()
//        if(model.isExpired) {
//            viewBG.cornerBorder(width: 1, color: .red)
//            vwMainExpired.isHidden = false
//        }
//        else {
//            viewBG.cornerBorder(width: 1, color: .lightGray)
//            vwMainExpired.isHidden = true
//        }
    }

}
