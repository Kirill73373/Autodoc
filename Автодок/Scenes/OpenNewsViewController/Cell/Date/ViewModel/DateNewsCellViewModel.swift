//
//  DateNewsCellViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 19.03.2023.
//

import Foundation

final class DateNewsCellViewModel: CellNewsViewModelProtocol {

    //MARK: - Private(Read Only) Property
    
    private(set) var identifier: String = "DateNewsCell"
    private(set) var type: OpenNewsType = .date
    
    //MARK: - Public Property
    
    var model: NewsItemModel?
    
    //MARK: - Initiation
    
    init(model: NewsItemModel?) {
        self.model = model
    }
}
