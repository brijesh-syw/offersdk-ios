//
//  FontScheme.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 06/08/24.
//

import Foundation
import UIKit

//MARK:  Font Constant
//
//struct FontConstant {
//
//    static let kBoldFont                        = "AvenirNext-DemiBold"
//    static let kMediumFont                      = "AvenirNext-Medium"
//    static let kRegularFont                     = "AvenirNext-Regular"
//}

class FontScheme: NSObject {

    static func fontFromConstant(fontName: String, size : CGFloat) -> UIFont {
        
        var result = UIFont()
        switch fontName {
        case "kRegularFont":
            result = self.kRegularFont(size: size)
            break
        case "kBoldFont":
            result = self.kBoldFont(size: size)
            break
        case "kMediumFont":
            result = self.kMediumFont(size: size)
            break
        default:
            result = self.kRegularFont(size: size)
        }
        
        return result
    }
    
    //Regular
    static func kRegularFont(size : CGFloat) -> UIFont  {
                
        return ThemeSettings.shared.fontSetting.regularFont.withSize(size)
    }
    
    //Medium
    static func kMediumFont(size : CGFloat) -> UIFont  {

        return ThemeSettings.shared.fontSetting.mediumFont.withSize(size)
    }

    //Bold
    static func kBoldFont(size : CGFloat) -> UIFont  {
        
        return ThemeSettings.shared.fontSetting.boldFont.withSize(size)
        

//        return UIFont(name: ThemeSettings.shared.fontSetting.boldFont.fontName, size: size)!
    }
    
}
