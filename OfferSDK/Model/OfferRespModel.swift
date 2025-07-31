//
//  OfferRespModel.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 01/07/24.
//

import Foundation


public struct ErrorRespModel: Codable {
    let isValid: Bool
    let errors: [OfferRespErrorModel]
}

public struct OfferRespErrorModel: Codable {
    let code: String?
    let type: String?
    let message : String?
}


struct OfferRespModel : Codable {
    
    let status : String
    let code : String
    let responseTime : String
    let traceId : String

    var contentOffers : [OfferModel]?
    
}

struct OfferModel : Codable {
    
    var sywOffercode : String?
    var callToActionURL : String?
    var subCategory : String?
    var offerStartDate : String?
    var offerName : String?
    var redemptionEnd : String?
    var issuanceTouchpoint : String?
    var contentId : String?
    var memberGroup : String?
    var buCode : String?
    var offerType : String?
    var disclaimerLegalCopy : String?
    var headline1 : String?
    var staticImage:String?
    var imageUrl1 : DynamicJSONProperty?
    var imageId : String?
    var imageName : String?
    var headline2 : String?
    var offerDescription : String?
    var permanentBlacklist : String?
    var redemptionEndOffset : String?
    var bodyline1 : String?
    var redemptionStartOffset : String?
    var category : String?
    var redemptionStart : String?
    var updateTS : String?
    var offerEndDate : String?
    var isRegister : String?
    var regStartDate : String?
    var regEndDate : String?

    
    var isRegisteredOffer : Bool {
        if(isRegister == "Y" || isRegister == "y") {
            return true
        }
        else {
            return false
        }
    }
    
    func getOfferEndCaption() -> String {
        if let endDate = offerEndDate {
            return "Expires on: \(endDate)"
        }
        return ""
    }
    
    var isExpireSoon : Bool {
        if(isRegister == "Y" || isRegister == "y") {
            //date logic
            if let endDT = offerEndDate, let offerEndDate = Date().getDateFromString(dt: endDT, formate: "yyyy/MM/dd") {
                //
                let next5DaysDt = Calendar.current.date(byAdding: Calendar.Component.day, value: 5, to: Date())!
                print("Next 5 days date: \(next5DaysDt)")
                if(offerEndDate <= next5DaysDt) {
                    return true
                }
                else {
                    return false
                }
            }
            
        }
        return false
    }
    
    func getImageURL(env:OfferEnvironment) -> String {
        
        if imageUrl1 != nil {
            switch imageUrl1 {
            case .obj(let value):
                return env.getImageBaseURL(imageId: value.imageId ?? "", imageName: value.imageName ?? "", partnerId: value.partnerId ?? "")
            case .string(let value):
                return value
            default:
                print("None")
            }
        }
        else if let imgURL = staticImage, imgURL.count > 0, imgURL.contains("http") {
            return imgURL
        }
        
//        if let imgURL = imageUrl1, (imgURL.imageId?.count ?? 0) > 0 {
//            return env.getImageBaseURL(imageId: imgURL.imageId ?? "", imageName: imgURL.imageName ?? "", partnerId: imgURL.partnerId ?? "")
//        }
//        else if let imgURL = staticImage, imgURL.count > 0, imgURL.contains("http") {
//            return imgURL
//        }
        
        return ""
    }
}




struct OfferRegisterRespModel : Codable {
    
    var status : String?
    var code : String?
    var erroCode : String?
    var errors: [OfferRespErrorModel]?
    
}



struct ImageUrlModel : Codable {
    
    var imageId : String?
    var imageName : String?
    var imagePath : String?
    var partnerId : String?
    
//    init(from decoder: Decoder) throws {
//        do {
//            wrappedValue = try decoder.singleValueContainer().decode(ImageUrlModel.self).value
//        } catch DecodingError.typeMismatch {
//            let bool = try decoder.singleValueContainer().decode(Bool.self)
//            guard !bool else {
//                throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Corrupted data"))
//            }
//            wrappedValue = nil
//        }
//    }
    
//    // Where we determine what type the value is
//    init(from decoder: Decoder) throws {
//        let container =  try decoder.singleValueContainer()
//
//        // Check for a boolean
//        do {
//            let object = try container.decode(ImageUrlModel.self)
//            imageId = object.imageId
//            imageName = object.imageName
//            imagePath = object.imagePath
//            partnerId = object.partnerId
//        } catch {
//            // Check for an integer
//            let object = try container.decode(String.self)
//            imageURL = object
//        }
//    }
}
enum DynamicJSONProperty: Codable {
    case obj(ImageUrlModel)
    case string(String)

    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()

        // Decode the double
        do {
            let doubleVal = try container.decode(ImageUrlModel.self)
            self = .obj(doubleVal)
        } catch DecodingError.typeMismatch {
            // Decode the string
            let stringVal = try container.decode(String.self)
            self = .string(stringVal)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .obj(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}


//struct OffersData : Codable {
//    var offerExtended : [OfferModel]?
//    var offer : [String]?
//
//    func getAvailableOffer() -> [OfferModel] {
//        return offerExtended?.filter({ model in
//            if (model.used == "N") {
//                //
//                if let currentDT = Date().getUTCDate(),
//                    let offerStarttDT = Date().getUTCDateFromString(dt: model.startDTTM ?? ""),
//                    let offerEndDT = Date().getUTCDateFromString(dt: model.endDTTM ?? "") {
//
//                    return ((offerStarttDT < currentDT) && (currentDT < offerEndDT))
//                }
//            }
//            return false
//
//        }) ?? []
//    }
//
//    func getRedeemedOffer() -> [OfferModel] {
//        return offerExtended?.filter({ model in
//            return model.used == "Y"
//        }) ?? []
//    }
//
//    func getExpiredOffer() -> [OfferModel] {
//        return offerExtended?.filter({ model in
//
//            if model.used != "Y", let currentDT = Date().getUTCDate(), let offerEndDT = Date().getUTCDateFromString(dt: model.endDTTM ?? "") {
//                return currentDT > offerEndDT
//            }
//            return false
//        }) ?? []
//    }
//}


//struct OfferModel : Codable {
//    var offerNumber : String?
//    var description : String?
//    var used : String?
//    var category : String?
//    var startDTTM : String?
//    var endDTTM : String?
//    var pointAvailableTs : String?
//    var pointExpiryTs : String?
//    var terms : String?
//    var subCategory : String?
//    var programType : String?
//    var offerName : String?
//    var imageName : String?
//    var programSubType : String?
//    var offerMemberGroupDetailList : OfferMemberGroupDetailList?
//    var isExpired: Bool  {
//        return false
//    }
//
//    func getExpiredDate() -> String {
//        if let offerEndDT = Date().getUTCDateFromString(dt: endDTTM ?? "") {
//            return "Expires on \(Date().getDateString(dt: offerEndDT))"
//        }
//        return ""
//    }
//
//
//}

//struct OfferMemberGroupDetailList : Codable {
//    var offerMemberGroupDetail : [OfferMemberGroupDetailModel]?
//}
//
//struct OfferMemberGroupDetailModel : Codable {
//    var registrationStartDate : String?
//    var groupName : String?
//    var registrationEndDate : String?
//    var additionalGroupInfo : String?
//    var registrationSeqNumber : String?
//
//}
//
//struct AdditionalModel : Codable {
//    var status : String?
//    var statusText : String?
//    var sysPulse : String?
//
//}
//
//
//struct OfferModel : Codable {
//    var offerNumber : String?
//    var description : String?
//    var used : String?
//    var category : String?
//    var subCategory : String?
//    var terms : String?
//    var startDTTM : String?
//    var endDTTM : String?
//    var pointAvailableTs : String?
//    var pointExpiryTs : String?
//    var programType : String?
//    var offerName : String?
//    var imageName : String?
//    var programSubType : String?
//    var offerMemberGroupDetailList : OfferMemberGroupDetailList?
//    var contentDetails : [ContentDetailsModel]?
//
//    var isExpired: Bool  {
//        return false
//    }
//
//    func getContent() -> ContentDetailsModel? {
//        if(contentDetails != nil && (contentDetails?.count ?? 0) > 0) {
//            return contentDetails?.first
//        }
//        return nil
//    }
//
//    func getExpiredDate() -> String {
//        if let offerEndDT = Date().getUTCDateFromString(dt: endDTTM ?? "") {
//            return "Expires on \(Date().getDateString(dt: offerEndDT))"
//        }
//        return ""
//    }
//
//
//}
//
//struct ContentDetailsModel : Codable {
//    var sywrOfferCode : String?
//    var subCategory : String?
//    var sywProgramType : String?
//    var redemptionEnd : String?
//    var contentId : String?
//    var offerType : String?
//    var disclaimerLegalCopy : String?
//    var permanentBlacklist : String?
//    var redemptionEndOffset : String?
//    var redemptionStart : String?
//    var updateTS : String?
//    var callToActionURL : String?
//    var offerStartDate : String?
//    var imageId : String?
//    var imageName : String?
//    var offerName : String?
//    var issuanceTouchpoint : String?
//    var buCode : String?
//    var headline1 : String?
//    var imageUrl1 : String?
//    var offerDescription : String?
//    var bodyline1 : String?
//    var redemptionStartOffset : String?
//    var category : String?
//    var offerEndDate : String?
//
//}



