//
//  UIView.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ view: UIView...) {
        view.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func usingSpringWithDampingAnimation(withDuration: CGFloat = 1, usingSpringWithDamping: CGFloat = 1, delay: CGFloat = 0.5, completionAnimate: (() -> Void)?, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: withDuration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: 8, options: [.curveEaseInOut, .allowUserInteraction, .curveLinear]) {
            completionAnimate?()
        } completion: { _ in
            completion?()
        }
    }
    
    enum CornerType {
        case all
        case top
        case bottom
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case topLeftBottomRight
        case bottomLeftTopRight
    }
    
    func cornerType(type: CornerType, radius: CGFloat) {
        layer.cornerRadius = radius
        switch type {
        case .topLeft:
            layer.maskedCorners = [.layerMinXMinYCorner]
        case .topRight:
            layer.maskedCorners = [.layerMaxXMinYCorner]
        case .bottomLeft:
            layer.maskedCorners = [.layerMinXMaxYCorner]
        case .bottomRight:
            layer.maskedCorners = [.layerMaxXMaxYCorner]
        case .all:
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .top:
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case .bottom:
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        case .topLeftBottomRight:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        case .bottomLeftTopRight:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        }
    }
}
