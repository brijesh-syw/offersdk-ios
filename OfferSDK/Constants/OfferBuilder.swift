//
//  OfferBuilder.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 16/09/24.
//

import Foundation
import UIKit

private enum Constants {
    static let defaultMerchantId = "TELL_FFBTEST_UAT"
    static let organisation = "FFB"
}

public final class OfferBuilder {
    private let refId: String
    private let environment: OfferEnvironment
    private var merchantId: String = Constants.defaultMerchantId
    private var organization : String = Constants.organisation
    private var programType : String  = ""
//    private let showMemberNumber:Bool
//    private let showMemberName:Bool
//    private let showExpiringPoints:Bool
//    private let sdkVersion: String
    
    
   
    /**
    Creates a new instance of PywBuilder with the following parameters
     - Parameters:
        - refId: Unique identifier provided by the backed.
        - transactionId: Unique transaction id.
        - environmet: Develpment or production environment.
        - delegate: AnyObject which will listen for updates from the SDK.
     */
    public init(refId: String, environment: OfferEnvironment, merchantId: String, organization: String, programType : String) {
        self.refId = refId
        self.environment = environment
        self.merchantId = merchantId
        self.organization = organization
        self.programType = programType
    }
    
    /**
    Generates object of type `PywConfig` from `PywBuilder` object.
    */
    public func build() -> OfferConfig {
        return OfferConfig(
            refId: refId,
            environment: environment,
            merchantId: merchantId,
            organization: organization,
            programType : programType
        )
    }
    
    public func getOfferVC(config: OfferConfig) -> UIViewController {
        
        let bundle = Bundle(for: type(of: self))
        let vc = OfferVC(nibName: "OfferVC", bundle: bundle)
        vc.config = config
        return vc
    }
}

