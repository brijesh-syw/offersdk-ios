//
//  OfferConfig.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 16/09/24.
//

import Foundation
import UIKit


public struct OfferConfig {
    let refId: String
    let environment: OfferEnvironment
    let merchantId: String
    let organization : String
    let programType : String
    
    init(refId: String, environment: OfferEnvironment, merchantId: String, organization: String, programType : String) {
        self.refId = refId
        self.environment = environment
        self.merchantId = merchantId
        self.organization = organization
        self.programType = programType
    }
    

    
}

extension OfferConfig: Equatable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(refId)
        hasher.combine(environment)
        hasher.combine(merchantId)
        hasher.combine(organization)
        hasher.combine(programType)
    }
    
    public static func == (lhs: OfferConfig, rhs: OfferConfig) -> Bool {
        return lhs.refId == rhs.refId &&
        lhs.environment == rhs.environment &&
        lhs.merchantId == rhs.merchantId &&
        lhs.organization == rhs.organization &&
        lhs.programType == rhs.programType
    }
}
