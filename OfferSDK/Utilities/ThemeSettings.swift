//
//  ThemeSettings.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 29/07/24.
//

import Foundation
import UIKit

public struct ColorSettings {
    
    var primaryColor: UIColor
    var secondaryColor: UIColor
    var primaryTextColor: UIColor
    var secondaryTextColor: UIColor
    var primaryButtonBGColor: UIColor
    var secondaryButtonBGColor: UIColor
    
//    static var font: UIFont?
    
    public init(primaryColor: UIColor, secondaryColor: UIColor, primaryTextColor: UIColor, secondaryTextColor: UIColor, primaryButtonBGColor: UIColor, secondaryButtonBGColor: UIColor) {
        
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColor = secondaryTextColor
        self.primaryButtonBGColor = primaryButtonBGColor
        self.secondaryButtonBGColor = secondaryButtonBGColor
    }
    
    static public func getDefaultTheme() -> ColorSettings {
        
        return ColorSettings(primaryColor: UIColor(rgb: 0x0066cc), secondaryColor: UIColor.yellow, primaryTextColor: UIColor.black, secondaryTextColor: UIColor.white, primaryButtonBGColor: UIColor.red, secondaryButtonBGColor: UIColor.black)
        
        //return ColorSettings(primaryColor: UIColor.blue, secondaryColor: UIColor.blue, primaryTextColor: UIColor.blue, secondaryTextColor: UIColor.blue, primaryButtonBGColor: UIColor.blue, secondaryButtonBGColor: UIColor.white)
       
    }
}


public struct FontSettings {
    
    var regularFont: UIFont
    var mediumFont: UIFont
    var boldFont: UIFont
    
    public init(regularFont: UIFont, mediumFont: UIFont, boldFont: UIFont) {
        
        self.regularFont = regularFont
        self.mediumFont = mediumFont
        self.boldFont = boldFont
    }
    
    static public func getDefaultFont() -> FontSettings {    
        
        return FontSettings(regularFont: UIFont.systemFont(ofSize: 18, weight: .regular), mediumFont: UIFont.systemFont(ofSize: 18, weight: .medium), boldFont: UIFont.boldSystemFont(ofSize: 18))
    }
}


public class ThemeSettings : NSObject {
    
    public static let shared = ThemeSettings(colorSetting: ColorSettings.getDefaultTheme(), fontSetting: FontSettings.getDefaultFont())
    public var colorSetting: ColorSettings
    public var fontSetting: FontSettings
    
    
    private init (colorSetting: ColorSettings, fontSetting: FontSettings) {
        self.colorSetting = colorSetting
        self.fontSetting = fontSetting
    }
}

