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
    
    func loadImageCache(urlString: String) -> URLSessionDataTask? {
        image = nil
        
        guard let url = URL(string: urlString) else { return nil }
        if let imageToCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageToCache
            return nil
        }
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = ColorHelper.redColor
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let imageToCache = UIImage(data: data ?? Data())
                imageCache.setObject(imageToCache ?? UIImage(), forKey: urlString as NSString)
                self.image = imageToCache
                activityIndicator.removeFromSuperview()
            }
        }
        
        task.resume()
        return task
    }
}
