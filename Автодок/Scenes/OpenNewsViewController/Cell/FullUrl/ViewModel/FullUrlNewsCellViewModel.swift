//
//  FullUrlNewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class FullUrlNewsCellViewModel: CellNewsViewModelProtocol {
    
    //MARK: - Private(Read Only) Property
    
    private(set) var identifier: String = "FullUrlNewsCell"
    private(set) var type: OpenNewsType = .fullUrl
    
    //MARK: - Public Property
    
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}
