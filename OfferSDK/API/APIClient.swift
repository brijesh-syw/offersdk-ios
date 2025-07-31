//
//  APIClient.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 01/07/24.
//

import Foundation
import Combine

typealias RequestResultCallback<T> = (Result<T, Error>) -> Void

final class APIClient : NSObject {
    
    // MARK: - Properties
    
    /// The URLSession handing the URLSessionTaks.
    let config: OfferConfig
    private var cancellable: AnyCancellable?
    
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        decoder.dataDecodingStrategy = .deferredToData
        return decoder
    }()
    
    private lazy var urlSession: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30
        sessionConfiguration.waitsForConnectivity = true
        
        // Create a `OperationQueue` instance for scheduling the delegate calls and completion handlers.
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated
        
        let urlSession = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: queue)
        return urlSession
    }()
    
    // MARK: - Initialization
    
    /// Convenience initializer.
    init(with configuration: OfferConfig) {
        // Configure the default URLSessionConfiguration.
        self.config = configuration
        super.init()
    }
    
    // MARK: - Requests
    
    func dataTask<T: Codable>(with request: URLRequest, responseType: T.Type, completionHandler: @escaping RequestResultCallback<T?>) {
        
        self.cancellable = urlSession.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { (data: Data, urlResponse: URLResponse) in
                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                    completionHandler(.failure(APIError.invalidResponse(urlResponse.url)))
                    throw URLError(.badServerResponse)
                }

                switch httpResponse.statusCode {
                    case 200...299:
                        // Will need to thing about something more clever

                        // If response is empty, then we return nil
                        if let data = String(data: data, encoding: .utf8) {
                            if data.count > 2 {
                                break
                            } else {
                                completionHandler(.success(nil))
                                self.cancellable?.cancel()
                            }
                        }
                    case 400...499:
                            completionHandler(.failure(APIError.noData(urlResponse.url)))
                    case 500...599:
                            completionHandler(.failure(APIError.serverError(nil, urlResponse.url)))
                    default:
                        completionHandler(.failure(APIError.unknown(urlResponse.url)))
                }

                return data
            }
            .decode(type: responseType.self, decoder: jsonDecoder)
            .retry(3)
            .sink { completion in
                switch completion {
                    case .finished: break
                    case .failure(let error):
                        completionHandler(.failure(error))
                }
            } receiveValue: { value in
                completionHandler(.success(value))
            }
    }
    
    
    // MARK: - Helpers

    public enum APIError: Error {
        /// No data received from the server.
        case noData(URL?)
        /// The server response was invalid (unexpected format).
        case invalidResponse(URL?)
        /// The request was rejected: 400-499
        case badRequest(String?, URL?)
        /// Encoutered a server error.
        case serverError(String?, URL?)
        /// There was an error parsing the data.
        case parseError(String?, URL?)
        /// Unknown error.
        case unknown(URL?)
    }
}
