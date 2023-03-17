//
//  NewsViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import Foundation
import Combine

final class NewsViewModel {
        
    //MARK: - Private Property
    
    private let networkService: NetworkService?
    
    //MARK: - Private(Read Only) Property
    
    private(set) var subjectModel = PassthroughSubject<NewsModel, Never>()
   
    //MARK: - Public Property
    
    var model: NewsModel?
    var modelCopy: NewsModel?
    var selectedIndex: Int?
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Initiation
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    //MARK: - Public Method
    
    func getNewsRequest() {
        Task(priority: .userInitiated) {
            do {
                guard let networkService = networkService else { return }
                let response = try await networkService.request(.news, for: NewsModel.self)
                subjectModel.send(response ?? NewsModel(news: [], totalCount: 0))
            } catch {
                print(error)
            }
        }
    }
}
