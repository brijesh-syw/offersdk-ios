//
//  ExtensionClass.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 29/07/24.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    func dropShadow()  {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero;
        self.layer.shadowRadius = 1.0;
        self.layer.shadowOpacity = 0.5;
        self.layer.masksToBounds = false;
        self.clipsToBounds = false;
    }
    
//    func dropShadow(scale: Bool = true) {
//      self.layer.masksToBounds = false
//      self.layer.shadowColor = UIColor.black.cgColor
//      self.layer.shadowOpacity = 0.5
//      self.layer.shadowOffset = CGSize(width: -1, height: 1)
//      self.layer.shadowRadius = 1
//      
//      //        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//      self.layer.shouldRasterize = true
//      self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
    

    @IBInspectable
    var BackgroundColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            backgroundColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String)
        }
    }
    
    @IBInspectable
    var TintColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            tintColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String)
        }
    }
    
    @IBInspectable
    var BorderColorKey: NSString   {

        get {
            return  "nil"
        }

        set {
            layer.borderColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String).cgColor
        }
    }
    
    @IBInspectable
    var CornerRadius: CGFloat   {
        
        get {
            return  0.0
        }
        
        set {
            layer.cornerRadius = newValue as CGFloat
        }
    }
    
    @IBInspectable
    var BorderWidth: CGFloat   {
        
        get {
            return  0.0
        }
        
        set {
            layer.borderWidth = newValue as CGFloat
        }
    }
    
    // set Corner Radius
    func setCornerRadius(radius:CGFloat = 4) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    
}

extension UILabel{
    
    @IBInspectable
    var TextColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {
            textColor = ColorScheme.colorFromConstant(textColorConstant: newValue as String)
        }
    }
    
    @IBInspectable
    var FontName: String  {
        get {
            return  UIFont.systemFont(ofSize: self.font.pointSize).familyName
        }
        set {
            font = FontScheme.fontFromConstant(fontName: newValue, size: self.font.pointSize)
        }
    }
    
    func setHTMLStringToLabel(text: String, align: NSTextAlignment = .left) {
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = align
        
        
        
        
        guard let attributedString = text.htmlToAttributedString else { return }
        
        
        let range = NSRange.init(location: 0, length: attributedString.length)
        
        
//        attributedString.addAttribute(
//            .paragraphStyle,
//            value: titleParagraphStyle,
//            range: attributedString.string.fullRange)
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: titleParagraphStyle,
            range: range)
        
//        if let font = UIFont(name: ThemeSettings.shared.fontSetting.font.familyName, size: self.font.pointSize) {
//            attributedString.addAttribute(
//                .font,
//                value: font,
//                range: range)
//        }
        
        
        titleParagraphStyle.lineSpacing = 0
        titleParagraphStyle.paragraphSpacing = 0
        titleParagraphStyle.paragraphSpacingBefore = 0
        
        self.attributedText = attributedString
        self.numberOfLines = 0
        self.sizeToFit()
    }
}


extension UIButton{
    
    @IBInspectable
    var TextColorKey: NSString   {
        
        get {
            return  "nil"
        }
        
        set {

            setTitleColor(ColorScheme.colorFromConstant(textColorConstant: newValue as String), for: .normal)
        }
    }
    
    @IBInspectable
    var FontName: String  {
        get {
            return  UIFont.systemFont(ofSize: self.titleLabel?.font.pointSize ?? 16).familyName
        }
        set {
            self.titleLabel?.font = FontScheme.fontFromConstant(fontName: newValue, size: self.titleLabel?.font.pointSize ?? 16)
        }
    }
}
