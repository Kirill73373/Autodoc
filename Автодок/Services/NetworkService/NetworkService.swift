//
//  NetworkService.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import Foundation


final class NetworkService {
    
    private var baseURLString: String {
        return "https://webapi.autodoc.ru/api"
    }
    
    enum PathType {
        case news
        
        var path: String {
            switch self {
            case .news:
                return "/news/1/15"
            }
        }
    }
    
    enum RequestMethod {
        case post
        case get
        
        var nameMethod: String {
            switch self {
            case .post:
                return "POST"
            case .get:
                return "GET"
            }
        }
    }
    
    func request<T: Decodable>(_ type: PathType, for: T.Type = T.self, method: RequestMethod = .get) async throws -> T? {
        guard let url = URL(string: baseURLString + type.path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.nameMethod
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(T.self, from: data)
        return response
    }
}
