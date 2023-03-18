//
//  OpenNewsViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import Foundation
import Combine

final class OpenNewsViewModel {
    
    //MARK: - Public property
    
    let model: NewsItemModel
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Public Lazy property
    
    lazy var items: [OpenNewsModel] = [
        OpenNewsModel(type: .picture, info: model.titleImageURL),
        OpenNewsModel(type: .title, info: model.title),
        OpenNewsModel(type: .description, info: model.description),
        OpenNewsModel(type: .fullUrl, info: model.title),
        OpenNewsModel(type: .date, info: model.publishedDate)
    ]
    
    init(model: NewsItemModel) {
        self.model = model
    }
}
