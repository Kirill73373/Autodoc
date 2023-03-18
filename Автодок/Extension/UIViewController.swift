//
//  UIViewController.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func style(_ transitionStyle: UIModalTransitionStyle, presentationStyle: UIModalPresentationStyle) {
        self.modalTransitionStyle = transitionStyle
        self.modalPresentationStyle = presentationStyle
    }
}
