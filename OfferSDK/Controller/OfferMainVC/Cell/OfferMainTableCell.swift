//
//  OfferMainTableCell.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 26/08/24.
//

import UIKit
//import SDWebImage

class OfferMainTableCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblOfferName: UILabel!
    @IBOutlet weak var lblStock: UILabel!    
    @IBOutlet weak var imgAdd: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAdd_Clicked(_ sender: UIButton) {
    }
    
    func setData(model: OfferModel) {
//        
////        lblOfferName.text = model.getContent()?.headline1 ?? ""
//        lblOfferName.setHTMLStringToLabel(text: model.getContent()?.headline1 ?? "")
//        lblStock.setHTMLStringToLabel(text: model.getContent()?.bodyline1 ?? "")
//        
//        
//        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
//        imgView.sd_setImage(with: URL(string: model.getContent()?.imageUrl1 ?? ""), placeholderImage: UIImage(named: "placeholder.png", in: getCurrentBundle(self), with: .none))
        
    }
    
}
