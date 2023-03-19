//
//  PictureNewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class PictureNewsCellViewModel: CellViewModelProtocol {
    
    //MARK: - Public Property
    
    var identifier: String = "PictureNewsCell"
    var type: OpenNewsType = .picture
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}

