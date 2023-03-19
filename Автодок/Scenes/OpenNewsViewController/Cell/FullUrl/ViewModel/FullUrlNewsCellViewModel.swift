//
//  FullUrlNewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class FullUrlNewsCellViewModel: CellViewModelProtocol {
    
    //MARK: - Public Property
    
    var identifier: String = "FullUrlNewsCell"
    var type: OpenNewsType = .fullUrl
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}

