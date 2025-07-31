//
//  URL+Extension.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 16/09/24.
//

import Foundation

extension URL {
    func queryItem<T: RawRepresentable>(_ queryParameterName: String) -> T? where T.RawValue == String {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        guard let result = url.queryItems?.first(where: { $0.name == queryParameterName })?.value else { return nil }
        return T(rawValue: result)
    }
    
    func queryItem(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        guard let result = url.queryItems?.first(where: { $0.name == queryParameterName })?.value else { return nil }
        return result
    }
    
    static func prepareUrl(with relativePath: String, environment: OfferEnvironment) -> URL {
        let urlString = environment.baseAPIUrl.absoluteString + relativePath
        return URL(string: urlString)!
    }

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        self = urlComponents.url!
    }

}
