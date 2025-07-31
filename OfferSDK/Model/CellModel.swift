//
//  CellModel.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 11/07/24.
//

import Foundation

class CellModel: NSObject {
    
    var text : String?
    var cellType : CellType?
    var isSelected : Bool = false

    override init() {
    }
    
    //Get Model
    
   class func getModel(text : String,type : CellType, isSelected:Bool) -> CellModel {
        
        let model = CellModel()
        model.text = text
        model.cellType = type
        model.isSelected = isSelected
        return model
    }
}


enum CellType {
    
    //Filter
    case FilterAvailable
    case FilterRedeemed
    case FilterExpired
}
