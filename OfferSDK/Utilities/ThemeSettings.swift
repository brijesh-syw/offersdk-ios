//
//  OfferThemeSettings.swift
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


public struct OfferFontSettings {
    
    var regularFont: UIFont
    var mediumFont: UIFont
    var boldFont: UIFont
    
    public init(regularFont: UIFont, mediumFont: UIFont, boldFont: UIFont) {
        
        self.regularFont = regularFont
        self.mediumFont = mediumFont
        self.boldFont = boldFont
    }
    
    static public func getDefaultFont() -> OfferFontSettings {    
        
        SDKFontLoader.registerFonts()
        
        let regular = UIFont.init(name: "Poppins-Regular", size: 20)
        let medium = UIFont.init(name: "Poppins-Medium", size: 20)
        let bold = UIFont.init(name: "Poppins-Bold", size: 20)
        
        return OfferFontSettings(regularFont: regular ?? UIFont.systemFont(ofSize: 18, weight: .regular), mediumFont: medium ?? UIFont.systemFont(ofSize: 18, weight: .medium), boldFont: bold ?? UIFont.boldSystemFont(ofSize: 18))
    }
    
    
    
}

public enum ThemeOption {
    case light
    case dark
}


public class OfferThemeSettings : NSObject {
    
    public static let shared = OfferThemeSettings(colorSetting: ColorSettings.getDefaultTheme(), fontSetting: OfferFontSettings.getDefaultFont())
    public let colorSetting: ColorSettings
    public let fontSetting: OfferFontSettings
    public var themeOption: ThemeOption = .light
    
    
    private init (colorSetting: ColorSettings, fontSetting: OfferFontSettings) {
        self.colorSetting = colorSetting
        self.fontSetting = fontSetting
    }
}


public final class SDKFontLoader {

    private static let fontFiles = [
        "Poppins-Regular",
        "Poppins-Medium",
        "Poppins-Bold"
    ]

    public static func registerFonts() {
        //        let bundle = Bundle(for: BundleFinder.self)
        let bundle = getCurrentBundle(self)
        
        fontFiles.forEach { fontName in
            
            // 👇 Check if already registered
            if UIFont(name: fontName, size: 12) != nil {
                return
            }
            
            
            guard let url = bundle.url(forResource: fontName, withExtension: "ttf") else {
                print("❌ Font not found: \(fontName)")
                return
            }
            
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}
