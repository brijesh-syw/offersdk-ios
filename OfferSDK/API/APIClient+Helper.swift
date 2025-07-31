//
//  APIClient+Helper.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 01/07/24.
//

import Foundation

let commonErrorMsg = "Whoops! Something went wrong.\nPlease try again later."

extension APIClient {
    
    func getOffer(local: Bool = false, completion: @escaping (OfferRespModel?) -> Void, completionWithError: @escaping (String?) -> Void) {
        
//        // For loading ONLY from local json file
//        guard local == false else {
//            completion(loadLocalData())
//            return
//        }
        
        
        
        
        let url = URL(string: "\(config.environment.baseAPIUrl)/tell/sdk/v1/getmembercontentoffers")
        var request = URLRequest(url: url!)

        request.httpMethod = "POST"

        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "organization" : config.organization,
            "client_id" : config.merchantId,
            "platform" : "telluride",
            "refId" : config.refId
        ]

        request.allHTTPHeaderFields = headers
        
        var filter : [String:Any] = [:]
        
        if(config.programType.count > 0) {
            filter["programType"] = config.programType
        }
        
        let body: [String: Any] = [
            "endDTTM": Date().getUTCDateString(),
            "startDTTM": Date().getUTCDateString(),
            "filter" : filter
        ]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        

        request.httpBody = jsonData
        
        if let jsonResponse = try? JSONSerialization.jsonObject(with: jsonData!) as? [String: Any] {
            print(jsonResponse)
        }

//        dataTask(with: request, responseType: OfferRespModel.self) { [weak self] result in
//            switch result {
//                case .success(let offerResp):
//                    if let resp = offerResp {
//                        completion(resp)
//                        return
//                    }
//
//                    completion(nil)
//                case .failure(let error):
//                print("Error => \(error)")
//                completionWithError("\(error)")
////                    completion(nil)
//            }
//        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                debugPrint("Error getting Prepare: \(error?.localizedDescription ?? "")")
                return
            }

            // ensure there is valid response code returned from this HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid Response received from the server")
                return
            }

            // ensure there is data returned
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }

            do {
                // create json object from data or use JSONDecoder to convert to Model stuct
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    print(jsonResponse)

                    if let data = data, let dict = try? JSONDecoder().decode(OfferRespModel.self, from: data) {
                        
                        DispatchQueue.main.async {
                            completion(dict)
                        }
                    }
//                    else if let data = data, let dict = try? JSONDecoder().decode(ErrorRespModel.self, from: data) {
//                        //
//
//                        if (dict.errors.count ?? 0) > 0, let errorMsg = dict.errors.first?.message {
//                            DispatchQueue.main.async {
//                                completionWithError(errorMsg)
//                            }
//                        }
//                        else {
//                            DispatchQueue.main.async {
//                                completionWithError("Whoops! Something went wrong. Please try again later")
//                            }
//                        }
//                    }
                    else {
                            //
                        print("======data maybe corrupted or in wrong format")
                        DispatchQueue.main.async {
                            completionWithError(commonErrorMsg)
                        }
                    }

                    // handle json response
                } else {
                    print("data maybe corrupted or in wrong format")
                    throw URLError(.badServerResponse)
                }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completionWithError(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    
    private func loadLocalData() -> OfferRespModel? {
        let data = Data(PywResources.json.utf8)
        
//        if let dict = try? JSONDecoder().decode(OfferRespModel.self, from: data) {
//
//            return dict
//
//        }
//        else {
//            debugPrint("Error parsing local json")
//        }

        do {
            let result = try JSONDecoder().decode(OfferRespModel.self, from: data)
            return result
        } catch {
            print(error.localizedDescription)
            debugPrint("Error parsing local json")
        }

        return nil
    }
    
    
    func registerOffer(model: OfferModel, completion: @escaping (String?) -> Void, completionWithError: @escaping (String?) -> Void) {
        
        let url = URL.prepareUrl(with: "/tell/sdk/v1/offerregistration", environment: config.environment)
        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "organization" : config.organization,
            "client_id" : config.merchantId,
            "platform" : "telluride",
            "refId" : config.refId
        ]

        request.allHTTPHeaderFields = headers
        
        
        let offerStartDate = Date().getDateFromString(dt: model.offerStartDate ?? "", formate: "yyyy/MM/dd") ?? Date()
        let offerEndDate = Date().getDateFromString(dt: model.offerEndDate ?? "", formate: "yyyy/MM/dd") ?? Date()
        
        let redemptionStartDate = Date().getDateFromString(dt: model.redemptionStart ?? "") ?? Date()
        let redemptionEndDate = Date().getDateFromString(dt: model.redemptionEnd ?? "") ?? Date()
        
        
        let contentOffer : [String:Any] = [
            "sywrOfferCode": model.sywOffercode ?? "",
            "offerStartDate": Date().getDateString(dt: offerStartDate, formate: "yyyy-MM-dd"),
            "offerEndDate": Date().getDateString(dt: offerEndDate, formate: "yyyy-MM-dd"),
            "redemptionStart": Date().getDateString(dt: redemptionStartDate, formate: "yyyy-MM-dd"),
            "redemptionEnd": Date().getDateString(dt: redemptionEndDate, formate: "yyyy-MM-dd"),
            "redemptionEndOffset": model.redemptionEndOffset ?? "",
            "redemptionStartOffset": model.redemptionStartOffset ?? "",
            "contentId": model.contentId ?? "",
            "offerType": model.offerType ?? ""
        ]
        
        let body: [String: Any] = [
            "contentOffer" : contentOffer
        ]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        

        request.httpBody = jsonData
        
        if let jsonResponse = try? JSONSerialization.jsonObject(with: jsonData!) as? [String: Any] {
            print(jsonResponse)
        }

        dataTask(with: request, responseType: OfferRegisterRespModel.self) { [weak self] result in
            switch result {
                case .success(let offerResp):
                    if let resp = offerResp {
                        if(resp.status != nil && (resp.status?.count ?? 0) > 0) {
                            if(resp.status?.lowercased() == "success") {
                                completion(resp.status)
                            }
                            else {
                                completionWithError("Offer cannot be registered, please try again later.")
                            }
                        }
                        else {
//                            if (resp.errors?.count ?? 0) > 0, let errorMsg = resp.errors?.first?.message {
//                                //DispatchQueue.main.async {
//                                    completionWithError(errorMsg)
//                                //}
//                            }
                            completionWithError(commonErrorMsg)
                        }
                        
                        
                        return
                    }

                    completion(nil)
                case .failure(let error):
                print("Error => \(error)")
//                completionWithError("\(error)")
                completionWithError(commonErrorMsg)
//                    completion(nil)
            }
        }
    }
    
}

enum PywResources {
    
    static let json = """
{
    "contentOffers": [
        {
            "sywrOfferCode": "245517",
            "subCategory": "LylCshBck",
            "programType": "TestProgramFFB3",
            "offerStartDate": "2024/09/23",
            "offerName": "testCustomOffer2",
            "redemptionEnd": "2024-09-28 00:00:00",
            "org": "ffb",
            "issuanceTouchpoint": "Email",
            "contentId": "00-1247939",
            "buCode": "",
            "offerType": "LoyaltyCash",
            "headline1": "<p><b><strong style='color: rgb(0, 102, 204);' class='ql-size-large'>Buy 1 Get 1 Free</strong></b></p>",
            "imageUrl1": {
                "imageId": "download1_2024-09-26_at_01.22.03_AM_2CB0CWCJR.jpeg",
                "imageName": "download1.jpeg",
                "imagePath": "/ffb/contentoffer/download1_2024-09-26_at_01.22.03_AM_2CB0CWCJR.jpeg",
                "partnerId": "ffb"
            },
            "offerDescription": "",
            "permanentBlacklist": "",
            "redemptionEndOffset": "",
            "bodyline1": "<p><strong style='color: rgb(230, 0, 0);'>Get Twice the value with every purchase</strong></p>",
            "redemptionStartOffset": "",
            "category": "AWARD",
            "redemptionStart": "2024-09-26 00:00:00",
            "updateTS": "2024-09-26 01:24:02",
            "offerEndDate": "2024/09/28"
        }
    ],
    "status": "success",
    "code": "000",
    "responseTime": "23",
    "traceId": "f9afc63c-2b3d-4293-a6ca-b76db2a7b757"
}
"""
}
