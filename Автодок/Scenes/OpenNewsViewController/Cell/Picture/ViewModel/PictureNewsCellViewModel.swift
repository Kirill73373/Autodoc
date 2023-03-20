//
//  PictureNewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class PictureNewsCellViewModel: CellNewsViewModelProtocol {
    
    //MARK: - Private(Read Only) Property
    
    private(set) var identifier: String = "PictureNewsCell"
    private(set) var type: OpenNewsType = .picture
    
    //MARK: - Public Property
    
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}
