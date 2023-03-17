//
//  AlertHelpre.swift
//  Автодок
//
//  Created by Кирилл Блохин on 17.03.2023.
//

import Foundation
import UIKit

final class AlertHelper {
    
    static let shared = AlertHelper()
    
    func showAlert(title: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let actionFirst = UIAlertAction(title: actionTitle, style: .default)
        alert.addAction(actionFirst)
        guard let viewController = UIApplication.shared.windows.first?.rootViewController else { return }
        viewController.present(alert, animated: true)
    }
}
