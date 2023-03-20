//
//  OpenImageViewModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 17.03.2023.
//

import Foundation
import Combine

final class OpenImageViewModel {
    
    //MARK: - Public property
    
    var task: URLSessionDataTask?
    var cancellables = Set<AnyCancellable>()
    let urlStrng: String
    
    init(urlStrng: String) {
        self.urlStrng = urlStrng
    }
}
