//
//  OfferCategoryCell.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 11/07/24.
//

import UIKit

class OfferCategoryCell: UICollectionViewCell {

    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var vwIndicator: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//         let font = ThemeSettings.shared.fontSetting.font
//        lblText.font = font
//        lblText.font = UIFont(name: lblText.font.familyName, size: 30)
    }

    func setData(model:CellModel) {
        let bundle = getCurrentBundle(self)
        lblText.text = model.text
        if(model.isSelected) {
            vwIndicator.backgroundColor = ThemeSettings.shared.colorSetting.primaryColor
        }
        else {
            vwIndicator.backgroundColor = UIColor.clear
        }
        
    }
}
