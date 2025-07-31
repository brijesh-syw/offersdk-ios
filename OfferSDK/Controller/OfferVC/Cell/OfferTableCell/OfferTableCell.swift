//
//  OfferTableCell.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 22/07/24.
//

import UIKit

class OfferTableCell: UITableViewCell {
    
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var btnRedeem: UIButton!
    @IBOutlet weak var lblExpired: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        btnRedeem.cornerRadius(8)
        viewBG.cornerRadius(8)        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model: OfferModel) {
//        lblName.text = model.offerName ?? "-"
//        lblDesc.text = model.description ?? "-"
//        lblExpireDate.text = model.getExpiredDate()
//        
//        if(model.isExpired) {
//            viewBG.cornerBorder(width: 1, color: .red)
//            lblExpired.isHidden = false
//        }
//        else {
//            viewBG.cornerBorder(width: 1, color: .lightGray)
//            lblExpired.isHidden = true
//        }
    }
    
}
