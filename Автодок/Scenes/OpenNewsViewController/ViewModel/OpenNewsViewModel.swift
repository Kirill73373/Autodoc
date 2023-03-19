//
//  OpenNewsViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import Foundation
import Combine
import UIKit

final class OpenNewsViewModel {
    
    private(set) var cellViewModels = [CellViewModelProtocol]()
    
    //MARK: - Public Property
    
    let model: NewsItemModel
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Initilization
   
    init(model: NewsItemModel) {
        self.model = model
    }
    
    //MARK: - Public Method
    
    func getCellViewModel(at indexPath: IndexPath) -> CellViewModelProtocol {
        return cellViewModels[indexPath.row]
    }
        
    func appendCell() {
        cellViewModels = [
            PictureNewsCellViewModel(model: model),
            TitleNewsCellViewModel(model: model),
            DescriptionNewsCellViewModel(model: model),
            FullUrlNewsCellViewModel(model: model),
            DateNewsCellViewModel(model: model)
        ]
    }
}
