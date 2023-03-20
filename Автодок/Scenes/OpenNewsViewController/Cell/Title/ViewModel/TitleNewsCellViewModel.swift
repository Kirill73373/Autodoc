//
//  TitleNewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class TitleNewsCellViewModel: CellNewsViewModelProtocol {
    
    //MARK: - Private(Read Only) Property
    
    private(set) var identifier: String = "TitleNewsCell"
    private(set) var type: OpenNewsType = .title
    
    //MARK: - Public Property
    
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}
