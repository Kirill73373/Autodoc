//
//  DateNewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class DateNewsCellViewModel: CellViewModelProtocol {
    
    //MARK: - Public Property
    
    var identifier: String = "DateNewsCell"
    var type: OpenNewsType = .date
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}

