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
    
    var cancellables = Set<AnyCancellable>()
    var urlStrng: String?
}
