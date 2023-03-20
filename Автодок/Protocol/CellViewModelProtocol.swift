//
//  CellViewModelProtocol.swift
//  Автодок
//
//  Created by Кирилл Блохин on 20.03.2023.
//

import Foundation

protocol CellBaseViewModelProtocol {
    var type: OpenNewsType { get }
    var identifier: String { get }
}

protocol CellNewsViewModelProtocol: CellBaseViewModelProtocol {
    var model: NewsItemModel? { get set }
    init(model: NewsItemModel?)
}
