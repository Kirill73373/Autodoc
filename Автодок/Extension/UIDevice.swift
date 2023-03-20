//
//  UIDevice.swift
//  Автодок
//
//  Created by Кирилл Блохин on 18.03.2023.
//

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
