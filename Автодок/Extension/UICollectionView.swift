//
//  UICollectionView.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func scroll(row: Int) {
        let indexPath = IndexPath(row: 0, section: row)
        scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    func registerCells(_ cell: UIView.Type...) {
        cell.forEach {
            register($0.self, forCellWithReuseIdentifier: String(describing: $0))
        }
    }
    
    func animationReloadData() {
        UIView.transition(with: self, duration: 0.25, options: [.allowAnimatedContent, .transitionCrossDissolve, .curveEaseInOut], animations: {
            self.reloadData()
        })
    }
}
