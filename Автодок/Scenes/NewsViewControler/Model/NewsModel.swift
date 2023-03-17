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
    let title: String
    let description: String
    let publishedDate: String
    let url: String
    let fullURL: String
    let titleImageURL: String
    let categoryType: CategoryType

    enum CodingKeys: String, CodingKey {
        case id, title, description, publishedDate, url
        case fullURL = "fullUrl"
        case titleImageURL = "titleImageUrl"
        case categoryType
    }
}

enum CategoryType: String, Decodable {
    case carNews = "Автомобильные новости"
}
