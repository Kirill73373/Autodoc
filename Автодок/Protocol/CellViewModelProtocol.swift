//
//  CellViewModelProtocol.swift
//  Автодок
//
//  Created by Кирилл Блохин on 20.03.2023.
//

import Foundation

protocol CellViewModelProtocol {
    var model: NewsItemModel? { get set }
    var type: OpenNewsType { get set }
    var identifier: String { get set }
}
