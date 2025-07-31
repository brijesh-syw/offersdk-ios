//
//  ColorScheme.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 29/07/24.
//

import Foundation
import UIKit

class ColorScheme: NSObject {
    
    static func colorFromConstant(textColorConstant: String) -> UIColor {
        
        var result = UIColor()
        
        switch textColorConstant {
        case "kPrimaryColor":
            result = self.kPrimaryColor()
            break
        case "kSecondaryColor":
            result = self.kSecondaryColor()
            break            
        case "kPrimaryTextColor":
            result = self.kPrimaryTextColor()
            break
        case "kSecondaryTextColor":
            result = self.kSecondaryTextColor()
            break
        case "kPrimaryButtonBGColor":
            result = self.kPrimaryButtonBGColor()
            break
        case "kSecondaryButtonBGColor":
            result = self.kSecondaryButtonBGColor()
            break
            
            
        default:
            result = self.kPrimaryColor()
        }
      
        return result
    }
    
    //MARK: Private Methods
    
    static func kPrimaryColor() -> UIColor{
        
        return ThemeSettings.shared.colorSetting.primaryColor
    }
    static func kSecondaryColor() -> UIColor{
        return ThemeSettings.shared.colorSetting.secondaryColor
    }
    
    static func kPrimaryTextColor() -> UIColor{
        return ThemeSettings.shared.colorSetting.primaryTextColor
    }
    
    static func kSecondaryTextColor() -> UIColor{
        return ThemeSettings.shared.colorSetting.secondaryTextColor
    }
    
    static func kPrimaryButtonBGColor() -> UIColor{
        return ThemeSettings.shared.colorSetting.primaryButtonBGColor
    }
    
    static func kSecondaryButtonBGColor() -> UIColor{
        return ThemeSettings.shared.colorSetting.secondaryButtonBGColor
    }
    
    
    
}

