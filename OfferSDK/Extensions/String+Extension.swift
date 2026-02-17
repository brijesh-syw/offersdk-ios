//
//  String+Extension.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 02/09/24.
//

import Foundation
import UIKit

extension String {
    var alphanumeric: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
    }
    
    var getInt: Int {
        return Int(self) ?? 0
    }
    
    var getDouble: Double {
        return Double(self) ?? 0.0
    }
    
    func htmlToAttributedString(font:UIFont) -> NSMutableAttributedString? {
        
//         let font = UIFont(name: ThemeSettings.shared.fontSetting.regularFont.familyName, size: 30)
        
//        let modifiedFont = String(format:"<span style=\"font-family: \(font2.familyName);\">%@</span>", self)
        let modifiedFont = String(format:"<span style=\"font-family: \(font.fontName);\">%@</span>", self)
        
        
//        let modifiedFont = String(format:"<span style=\"font-family: \(font2.fontName);\">%@</span>", self)
        
        
        do {
            return try NSMutableAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)
            }
        catch {
            return nil
        }
        
    }
    
//    var htmlToAttributedString: NSMutableAttributedString? {
//        
//        
//        
////        guard let data = data(using: .utf8) else { return nil }
////        do {
////            return try NSMutableAttributedString(data: data, options: [.documentType: NSMutableAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
////        } catch {
////            return nil
////        }
//        
//        
//         let font = UIFont(name: ThemeSettings.shared.fontSetting.regularFont.familyName, size: 30)
//        
//        let modifiedFont = String(format:"<span style=\"font-family: \(font!.fontName);\">%@</span>", self)
//        //let modifiedFont = String(format:"<span style=\"font-family: \(font!.fontName);font-size: \(font!.pointSize)\">%@</span>", self)
////        let modifiedFont = String(format:"<span>%@</span>", self)
//        
//        do {
//            return try NSMutableAttributedString(
//            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
//            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
//            documentAttributes: nil)
//            }
//        catch {
//            return nil
//        }
////        let attrStr = try! NSAttributedString(
////                    data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
////                    options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
////                    documentAttributes: nil)
////
////                self.attributedText = attrStr
//        
//    }

//    var htmlToString: String {
//        return htmlToAttributedString?.string ?? ""
//    }
    
    var fullRange: NSRange {
        NSRange(location: 0, length: self.count)
    }
}
