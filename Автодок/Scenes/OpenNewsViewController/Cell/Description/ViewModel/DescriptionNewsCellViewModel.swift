//
//  DescriptionNewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class DescriptionNewsCellViewModel: CellNewsViewModelProtocol {
    
    //MARK: - Public Property
    
    var identifier: String = "DescriptionNewsCell"
    var type: OpenNewsType = .description
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}

