//
//  Loader.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import Foundation
import UIKit

final class LoaderIndicator {
    
    //MARK: - UI
    
    private let containerView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.redColor.withAlphaComponent(0.2)
        vw.layer.cornerRadius = 15
        return vw
    }()
    
    private let activityImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.activityIcon
        return img
    }()
    
    //MARK: - Static Property
    
    static let shared = LoaderIndicator()
    
    //MARK: - Public Method (Start Custom Activity View)
    
    func activateIndicator(_ isActive: Bool) {
        DispatchQueue.main.async {
            guard let view = UIApplication.shared.windows.last?.rootViewController?.view else { return }
            if isActive {
                view.addSubviews(
                    self.containerView
                )
                
                self.containerView.addSubviews(
                    self.activityImageView
                )
                
                self.containerView.translatesAutoresizingMaskIntoConstraints = false
                self.activityImageView.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    self.containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    self.containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    self.containerView.heightAnchor.constraint(equalToConstant: 100),
                    self.containerView.widthAnchor.constraint(equalToConstant: 100),
                    
                    self.activityImageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
                    self.activityImageView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
                    self.activityImageView.heightAnchor.constraint(equalToConstant: 48),
                    self.activityImageView.heightAnchor.constraint(equalToConstant: 48)
                ])
                self.activityImageView.rotateWithAnimation(angle: .pi * 2)
            } else {
                self.containerView.removeFromSuperview()
                self.activityImageView.removeFromSuperview()
            }
        }
    }
}
