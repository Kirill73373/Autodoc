//
//  NewsModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import Foundation

struct NewsModel: Decodable {
    var news: [NewsItemModel]
    let totalCount: Int
}

struct NewsItemModel: Decodable {
    let id: Int
    let title, description, publishedDate, url, fullURL, titleImageURL: String
    let categoryType: CategoryType
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, publishedDate, url, categoryType
        case fullURL = "fullUrl"
        case titleImageURL = "titleImageUrl"
    }
}

enum CategoryType: String, Decodable {
    case carNews = "Автомобильные новости"
}
