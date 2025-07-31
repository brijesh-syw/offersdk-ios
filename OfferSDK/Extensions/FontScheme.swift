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

    static func fontFromConstant(fontType:Int = 0, fontName: String, size : CGFloat) -> UIFont {
        
        var result = UIFont()
//        if fontType > 0 && fontType < 5 {
//            switch fontType {
//            case 1: // Section header
//                result = self.kBoldFont(size: 18)
//                break
//            case 2: // header
//                result = self.kBoldFont(size: 16)
//                break
//            case 3: // Sub header
//                result = self.kMediumFont(size: 14)
//                break
//            case 4: // Description
//                result = self.kRegularFont(size: 14)
//                break
//            default:
//                break
//            }
//        }
//        else {
            switch fontName {
            case "kRegularFont":
                result = self.kRegularFont(size: size)
                break
//            case "kBoldFont":
//                result = self.kBoldFont(size: size)
//                break
//            case "kMediumFont":
//                result = self.kMediumFont(size: size)
//                break
            default:
                result = self.kRegularFont(size: size)
            }
//        }
        
        return result
    }
    
    //Regular
    static func kRegularFont(size : CGFloat) -> UIFont  {
        
        return UIFont(name: ThemeSettings.shared.fontSetting.font.familyName, size: size)!
    }
    
//    //Medium
//    static func kMediumFont(size : CGFloat) -> UIFont  {
//
//        return UIFont(name: FontConstant.kMediumFont, size: size)!
//    }
//
//    //Bold
//    static func kBoldFont(size : CGFloat) -> UIFont  {
//
//        return UIFont(name: FontConstant.kBoldFont, size: size)!
//    }
    
}
