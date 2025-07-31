//
//  DateUtilities.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 17/07/24.
//

import Foundation


extension Date {
    
    func getUTCDateString() -> String {
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone(identifier: "UTC")
        dtf.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"

        return dtf.string(from: self)
    }
    
    func getUTCDateFromString(dt:String) -> Date? {
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone(identifier: "UTC")
        dtf.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"

        return dtf.date(from: dt)
    }
    
    
    func getDateFromString(dt:String, formate:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dtf = DateFormatter()
        dtf.dateFormat = formate

        return dtf.date(from: dt)
    }
    
    func getUTCDate() -> Date? {
        
        let value = Date()
        
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone(identifier: "UTC")
        dtf.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let currentdt = dtf.string(from: value)

        return dtf.date(from: currentdt)
    }
    
    func getDateString(dt:Date, formate: String = "MM/dd/yyyy") -> String {
        let dtf = DateFormatter()
        dtf.dateFormat = formate
        return dtf.string(from: dt)
    }
}
