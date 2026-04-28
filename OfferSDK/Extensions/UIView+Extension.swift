//
//  UIView+Extension.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 28/06/24.
//

import Foundation
import UIKit

extension UIView {
    
    func cornerRadius(_ value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
    
    func cornerBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor ]
//        gradientLayer.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 1.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius

       layer.insertSublayer(gradientLayer, at: 0)
    }
    
//    func addDashedBorder(radius: CGFloat, color: UIColor, dashPattern: [NSNumber] = [4, 4]) {
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.strokeColor = color.cgColor
//        shapeLayer.lineWidth = 2
//        shapeLayer.lineDashPattern = dashPattern
//        shapeLayer.fillColor = nil
//        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
//        self.layer.addSublayer(shapeLayer)
//    }
    
    func addDashedBorder(cornerRadius: CGFloat, dashPattern: [NSNumber] = [4, 2], borderColor: UIColor = OfferThemeSettings.shared.colorSetting.primaryColor.withAlphaComponent(0.4), borderWidth: CGFloat = 1) {
       
        removeDashBorder()
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedBorderLayer"
        shapeLayer.bounds = self.bounds
        shapeLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = borderColor.cgColor
        shapeLayer.lineWidth = borderWidth
        shapeLayer.lineDashPattern = dashPattern
        
        let path = UIBezierPath(
            roundedRect: self.bounds,
            cornerRadius: cornerRadius
        )
        
        shapeLayer.path = path.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func removeDashBorder() {
        // Remove old dashed layers if any
        self.layer.sublayers?.removeAll(where: { $0.name == "DashedBorderLayer" })
    }
    
    
    
    @discardableResult   // 1
    func fromNib<T : UIView>() -> T? {   // 2
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {    // 3
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        addSubview(contentView)     // 4
        contentView.translatesAutoresizingMaskIntoConstraints = false   // 5
        contentView.layoutAttachAll()   // 6
        return contentView   // 7
    }
    
    /// attaches all sides of the receiver to its parent view
    func layoutAttachAll(margin : CGFloat = 0.0) {
        let view = superview
        layoutAttachTop(to: view, margin: margin)
        layoutAttachBottom(to: view, margin: margin)
        layoutAttachLeading(to: view, margin: margin)
        layoutAttachTrailing(to: view, margin: margin)
    }
    
    /// attaches the top of the current view to the given view's top if it's a superview of the current view, or to it's bottom if it's not (assuming this is then a sibling view).
    /// if view is not provided, the current view's super view is used
    @discardableResult
    func layoutAttachTop(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = view == superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: isSuperview ? .top : .bottom, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the bottom of the current view to the given view
    @discardableResult
    func layoutAttachBottom(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the leading edge of the current view to the given view
    @discardableResult
    func layoutAttachLeading(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the trailing edge of the current view to the given view
    @discardableResult
    func layoutAttachTrailing(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
}
