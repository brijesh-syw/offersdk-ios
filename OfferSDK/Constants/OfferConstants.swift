//
//  OfferConstants.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 11/07/24.
//

import Foundation
import UIKit

struct OfferConstants {
    
    
}

func getCurrentBundle(_ view: AnyObject) -> Bundle {
//    let bundle = Bundle(for: type(of: self))
    return Bundle(for: type(of: view))
}


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
