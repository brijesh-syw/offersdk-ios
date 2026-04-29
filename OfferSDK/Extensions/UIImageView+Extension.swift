//
//  UIImageView+Extension.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh on 29/04/26.
//

import UIKit

extension UIImageView {

    func os_setImage(
        with url: URL?,
        placeholder: UIImage? = OSImageLoaderDefaults.shared.placeholder
    ) {
        OSImageLoader.shared.loadImage(
            url: url,
            into: self,
            placeholder: placeholder
        )
    }
}
