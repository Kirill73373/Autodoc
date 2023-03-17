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
    
    func loadImageCache(urlString: String, size: CGFloat) {
        image = nil
        if let image = imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                self.image = image.resizeWithWidth(width: size)
            }
            return
        }
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = ColorHelper.redColor
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        
        guard image == nil, let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let downloadedImage = UIImage(data: data ?? Data()) {
                DispatchQueue.main.async {
                    imageCache.setObject(downloadedImage.resizeWithWidth(width: size) ?? UIImage(), forKey: urlString as NSString)
                    self.image = downloadedImage.resizeWithWidth(width: size)
                    activityIndicator.removeFromSuperview()
                }
            }
        }).resume()
    }
}
