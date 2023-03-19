//
//  UICollectionViewCell.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    func viewModel(_ model: CellViewModelProtocol) {
        guard var cell = self as? MyCellProtocol else { return }
        cell.viewModel = model
    }
}
