//
//  NewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class NewsCellViewModel: CellNewsViewModelProtocol {
    
    //MARK: - Private(Read Only) Property
    
    private(set) var identifier: String = "NewsCell"
    private(set) var type: OpenNewsType = .other
    
    //MARK: - Public Property
    
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}
