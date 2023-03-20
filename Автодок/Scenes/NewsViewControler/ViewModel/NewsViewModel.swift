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
    
    private(set) var subjectModel = PassthroughSubject<Void, Never>()
    private(set) var cellViewModels = [CellNewsViewModelProtocol]() {
        didSet {
            subjectModel.send()
        }
    }
    
    //MARK: - Public Property
    
    var cellSearchViewModels = [CellNewsViewModelProtocol]()
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Initiation
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        getNewsRequest()
    }
    
    //MARK: - Public Method
    
    func getNewsRequest() {
        Task(priority: .background) {
            do {
                guard let networkService = networkService else { return }
                let response = try await networkService.request(.news, for: NewsModel.self)
                cellViewModels.removeAll()
                response?.news.forEach({ model in
                    cellViewModels.append(NewsCellViewModel(model: model))
                })
                cellSearchViewModels = cellViewModels
                subjectModel.send()
            } catch {
                print(error)
            }
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CellNewsViewModelProtocol {
        return cellSearchViewModels[indexPath.row]
    }
}
