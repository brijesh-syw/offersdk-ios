//
//  UIViewController+Extension.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 18/09/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        
        
        
        let constraintWidth = NSLayoutConstraint(
              item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
              NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 600)
           alert.view.addConstraint(constraintWidth)
        
        present(alert, animated: true)
        
        
        
        // duration in seconds
        let duration: Double = 2
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alertController, animated: true)
    }
}
