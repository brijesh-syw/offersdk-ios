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
    var offerBannerDetails : OfferBannerDetailModel?

    var contentOffers : [OfferModel]?
    var staticContentOffers : [OfferModel]?
    
    func getAvailableOffers() -> [OfferModel] {
//        return contentOffers?.filter({ model in
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
        
        var arr : [OfferModel] = []
                
        if let arrContent = contentOffers {
            let registered  = arrContent.filter { obj in
                return obj.isRegisteredOffer == true
            }.sorted(by: { obj1, obj2 in
                let obj1EndDate = Date().getDateFromString(dt: obj1.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
                let obj2EndDate = Date().getDateFromString(dt: obj2.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
                
                //            if(obj1EndDate == obj2EndDate){
                //                return (obj1.contentId ?? "").getInt < (obj2.contentId ?? "").getInt
                //            }
                return obj1EndDate < obj2EndDate
            })
            
            let unRegistered  = arrContent.filter { obj in
                return obj.isRegisteredOffer == false
            }.sorted(by: { obj1, obj2 in
                let obj1EndDate = Date().getDateFromString(dt: obj1.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
                let obj2EndDate = Date().getDateFromString(dt: obj2.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
                
                //            if(obj1EndDate == obj2EndDate){
                //                return (obj1.contentId ?? "").getInt < (obj2.contentId ?? "").getInt
                //            }
                return obj1EndDate < obj2EndDate
            })
            
            
            arr.append(contentsOf: registered)
            arr.append(contentsOf: unRegistered)
        }
        
        
        
        
        let fidemOffer = staticContentOffers ?? []
        
        let filteredStaticOffer = fidemOffer.filter { obj in
            return (obj.contentId?.count ?? 0) > 0
        }
        
        let arrStaticOffers = filteredStaticOffer.map { obj in
            //contentId
            var model = obj
            model.isStaticOffer = true
            return model
        }
        
        arr.append(contentsOf: arrStaticOffers)
        return arr
    }
    
    func getAddedOffers() -> [OfferModel] {
        return contentOffers?.filter({ model in
            return model.isRegisteredOffer == true
        }) ?? []
    }
    
    func getExpiringSoonOffers() -> [OfferModel] {
        return contentOffers?.filter({ model in
            return model.isExpireSoon == true
        }) ?? []
    }
    
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
    var headline2 : String?
    var headline3 : String?
    var headline4 : String?
    var staticImage:String?
    var imageUrl1 : DynamicJSONProperty?
    var imageId : String?
    var imageName : String?
    var offerDescription : String?
    var permanentBlacklist : String?
    var redemptionEndOffset : String?
    var bodyline1 : String?
    var bodyline2 : String?
    var bodyline3 : String?
    var bodyline4 : String?
    var ctaButtonText : String?
    var redemptionStartOffset : String?
    var category : String?
    var redemptionStart : String?
    var updateTS : String?
    var offerEndDate : String?
    var isRegister : String?
    var regStartDate : String?
    var regEndDate : String?
    
    var brandLogo : String?
    var brandName : String?
    var isExpiringSoon : String?
    var offsetDays : String?
    var isStaticOffer : Bool? = false
    
    
    var isRegisteredOffer : Bool {
        if(isRegister == "Y" || isRegister == "y") {
            return true
        }
        else {
            return false
        }
    }
    
    func getOfferEndCaption() -> String {
        if (isStaticOffer ?? false) {
            return "No expiration — always active"
        }
        else if let endDate = offerEndDate {
            let dt = Date().getDateFromString(dt: endDate, formate: "yyyy/MM/dd") ?? Date()
            return "Expires \(Date().getDateString(dt: dt, formate: "MM/dd/yy"))"
        }
        return ""
    }
    
    func getOfferEndCaptionForDetailPage() -> String {
        if (isStaticOffer ?? false) {
            return "No expiration — always active"
        }
        else if let endDate = offerEndDate {
            let dt = Date().getDateFromString(dt: endDate, formate: "yyyy/MM/dd") ?? Date()
            return "Expires on \(Date().getDateString(dt: dt, formate: "MMMM dd, yyyy"))"
        }
        return ""
    }
    
    func isShowAddButton() -> Bool {
        if let offercode = sywOffercode, offercode.count > 0 {
            return true
        }
        return false
    }
    
    var isExpireSoon : Bool {
        //        if(isRegister == "Y" || isRegister == "y") {
        //            //date logic
        //            if let endDT = offerEndDate, let offerEndDate = Date().getDateFromString(dt: endDT, formate: "yyyy/MM/dd") {
        //                //
        //                let next5DaysDt = Calendar.current.date(byAdding: Calendar.Component.day, value: 5, to: Date())!
        //                print("Next 5 days date: \(next5DaysDt)")
        //                if(offerEndDate <= next5DaysDt) {
        //                    return true
        //                }
        //                else {
        //                    return false
        //                }
        //            }
        //
        //        }
        
        
        if (isExpiringSoon == "Y" || isExpiringSoon == "y") {
            return true
        }
        return false
    }
    
    func calculateRegistrationEndDate() -> String {
        
        let offSet = Int(offsetDays ?? "0") ?? 0
        
        let currentPlusOffset = Calendar.current.date(byAdding: Calendar.Component.day, value: offSet, to: Date())!
        
        let offerEndDate = Date().getDateFromString(dt: offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
        
        //current date+offset or offerEndDate which ever is early
        if(currentPlusOffset <= offerEndDate) {
            return Date().getDateString(dt: currentPlusOffset, formate: "yyyy-MM-dd")
        }
        else {
            return Date().getDateString(dt: offerEndDate, formate: "yyyy-MM-dd")
        }
        
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
    
    func getWholeHeadline(isSkipFirst:Bool = false) -> String {
        var arrHeadline : [String] = []
        
        if !isSkipFirst, let headLineText = headline1, headLineText.count > 0 {
            arrHeadline.append(headLineText)
        }
        if let headLineText = headline2, headLineText.count > 0 {
            arrHeadline.append(headLineText)
        }
        if let headLineText = headline3, headLineText.count > 0 {
            arrHeadline.append(headLineText)
        }
        if let headLineText = headline4, headLineText.count > 0 {
            arrHeadline.append(headLineText)
        }
        
        return arrHeadline.joined(separator: "<br><br>")
    }
    
    func getWholeBodyline() -> String {
        var arrBodyline : [String] = []
        
        if let bodyLineText = bodyline1, bodyLineText.count > 0 {
            arrBodyline.append(bodyLineText)
        }
        if let bodyLineText = bodyline2, bodyLineText.count > 0 {
            arrBodyline.append(bodyLineText)
        }
        if let bodyLineText = bodyline3, bodyLineText.count > 0 {
            arrBodyline.append(bodyLineText)
        }
        if let bodyLineText = bodyline4, bodyLineText.count > 0 {
            arrBodyline.append(bodyLineText)
        }
        
        return arrBodyline.joined(separator: "<br><br>")
    }
    
    func getButtonText() -> String {
        if let btnText = ctaButtonText, btnText.count > 0 {
            return ctaButtonText ?? ""
        }
        return "Go to Website"
    }
    
}
struct OfferBannerDetailModel : Codable {
    
    var header : OfferBannerHeaderModel?
    var body : OfferBannerBodyModel?
    
}

struct OfferBannerHeaderModel : Codable {
    
    var title : String?
    var badge : String?
    
}

struct OfferBannerBodyModel : Codable {
    
    var text : String?
    
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



