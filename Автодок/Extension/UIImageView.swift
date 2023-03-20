//
//  UIImageView.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(urlString: String) {
        Task {
            do {
                try await loadImageCache(urlString: urlString)
            }
        }
    }
    
    func loadImageCache(urlString: String) async throws {
        image = nil
        
        guard let url = URL(string: urlString) else { return }
        if let imageToCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageToCache
            return
        }
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = ColorHelper.redColor
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        
        let urlRequest = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let imageToCache = UIImage(data: data)
        imageCache.setObject(imageToCache ?? UIImage(), forKey: urlString as NSString)
        self.image = imageToCache
        activityIndicator.removeFromSuperview()
    }
}
