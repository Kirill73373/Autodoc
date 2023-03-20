//
//  NewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class NewsCellViewModel: CellNewsViewModelProtocol {
    
    //MARK: - Public Property
    
    var identifier: String = "NewsCell"
    var type: OpenNewsType = .other
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}
