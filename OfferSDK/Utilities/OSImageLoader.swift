//
//  ImageLoader.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh on 29/04/26.
//

import UIKit

final class OSImageLoaderDefaults {
    static let shared = OSImageLoaderDefaults()
    var placeholder: UIImage?
}

final class OSImageLoader {
   
    static let shared = OSImageLoader()

    private let cache = NSCache<NSString, UIImage>()
//    private var runningTasks: [UIImageView: URLSessionDataTask] = [:]
    
    private var runningTasks = NSMapTable<UIImageView, URLSessionDataTask>(
            keyOptions: .weakMemory,
            valueOptions: .strongMemory
        )

    private var commonHeaders: [String: String] = [:]
    
    private let loaderTag = 999999

    private init() {}

    // MARK: - Configure headers once
    func configureHeaders(_ headers: [String: String]) {
        self.commonHeaders = headers
    }

    // MARK: - Load Image
    func loadImage(
        url: URL?,
        into imageView: UIImageView,
        placeholder: UIImage?
    ) {
        
        DispatchQueue.main.async {
            
            // Cancel previous request (IMPORTANT)
            if let existingTask = self.runningTasks.object(forKey: imageView) {
                existingTask.cancel()
                self.runningTasks.removeObject(forKey: imageView)
            }
            
            // Remove old loader
            self.removeLoader(from: imageView)
            
            guard let url = url else {
                imageView.image = placeholder
                return
            }
            
            let key = url.absoluteString as NSString
            
            // Cache hit
            if let cachedImage = self.cache.object(forKey: key) {
                imageView.image = cachedImage
                return
            }
            
            // Show placeholder first
            imageView.image = placeholder
            
            // Show loader
            self.addLoader(to: imageView)
            
            // Prepare request with headers
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            self.commonHeaders.forEach { request.setValue($1, forHTTPHeaderField: $0) }
            
            let task = URLSession.shared.dataTask(with: request) { [weak self, weak imageView] data, response, error in
                
                guard let self = self,
                      let imageView = imageView else { return }
                
                DispatchQueue.main.async {
                    self.removeLoader(from: imageView)
                }
                
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: key)
                    
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        imageView.image = placeholder
                    }
                }
                self.runningTasks.removeObject(forKey: imageView)
            }
            
            // Store task
            self.runningTasks.setObject(task, forKey: imageView)
            task.resume()
        }
    }

    // MARK: - Loader UI
//    private func addLoader(to imageView: UIImageView) -> UIActivityIndicatorView {
//        let indicator = UIActivityIndicatorView(style: .medium)
//        indicator.center = CGPoint(x: imageView.bounds.midX, y: imageView.bounds.midY)
//        indicator.hidesWhenStopped = true
//        indicator.startAnimating()
//
//        DispatchQueue.main.async {
//            imageView.addSubview(indicator)
//        }
//
//        return indicator
//    }
    
    private func addLoader(to imageView: UIImageView) {

        // Remove existing loader if any (prevents duplicates)
        if let existing = imageView.viewWithTag(loaderTag) as? UIActivityIndicatorView {
            existing.startAnimating()
            return
        }

        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.tag = loaderTag
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true

        imageView.addSubview(indicator)

        // Center using AutoLayout (fixes position issue)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])

        indicator.startAnimating()
//        return indicator
    }
    
    private func removeLoader(from imageView: UIImageView) {
            if let loader = imageView.viewWithTag(loaderTag) as? UIActivityIndicatorView {
                loader.stopAnimating()
                loader.removeFromSuperview()
            }
        }
}
