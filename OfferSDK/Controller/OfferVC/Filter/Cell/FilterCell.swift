//
//  FilterCell.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 11/07/24.
//

import UIKit

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var lblText: UILabel!    
    @IBOutlet weak var imgCheckbox: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model:CellModel) {
        let bundle = getCurrentBundle(self)
        lblText.text = model.text
        if(model.isSelected) {
            imgCheckbox.image = UIImage(named: "selected_checkbox.png", in: bundle, with: .none)
        }
        else {
            imgCheckbox.image = UIImage(named: "checkbox.png", in: bundle, with: .none)
        }
        
    }
    
}
