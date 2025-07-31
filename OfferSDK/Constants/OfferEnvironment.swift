//
//  OfferEnvironment.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 16/09/24.
//

import Foundation
/**
 Convinience enum for working with predefined environments.
 */

public enum OfferEnvironment {
    case prod
    case uat
    
    /// Base API URL which is used for communicating with PYW backend.
    var baseAPIUrl: URL {
        switch self {
        case .prod: return URL(string: "https://api.tellurideplatform.com")!
        case .uat: return URL(string: "https://api.qa.tellurideplatform.com")!
        }
    }
    
    func getImageBaseURL(imageId:String, imageName:String, partnerId:String) -> String {
        switch self {
        case .prod: return "https://api.tellurideplatform.com/tell/sdk/v1/viewimage?imageId=\(imageId)&imageName=\(imageName)&partnerId=\(partnerId)"
        case .uat: return "https://api.qa.tellurideplatform.com/tell/sdk/v1/viewimage?imageId=\(imageId)&imageName=\(imageName)&partnerId=\(partnerId)"
        }
    }
    

    
//https://api.qa.tellurideplatform.com/tell/sdk/v1/offerregistration
    
    
//    /// Base HTML URL which is used for internal HTML Pyw page.
//    var baseHTMLUrl: URL {
//        switch self {
//        case .prod: return URL(string: "https://pywweb.telluride.shopyourway.com")!
//        case .uat: return URL(string: "https://pywweb.uat.telluride.shopyourway.com")!
//        }
//    }
    
//    /// Widget data id, which is used for loading UI structure of the component from backend.
//    var getWidgetDataId: String {
//        switch self {
//        case .prod: return "1058303"
//        case .uat: return "943484"
//        }
//    }
}
