//
//  TitleNewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class TitleNewsCellViewModel: CellViewModelProtocol {
    
    //MARK: - Public Property
    
    var identifier: String = "TitleNewsCell"
    var type: OpenNewsType = .title
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}

