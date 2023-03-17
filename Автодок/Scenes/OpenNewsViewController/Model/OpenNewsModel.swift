//
//  OpenNewsModel.swift
//  Автодок
//
//  Created by Кирилл Блохин on 17.03.2023.
//

import Foundation

struct OpenNewsModel {
    var type: OpenNewsType
    var info: String
}

enum OpenNewsType: Int {
    case picture
    case title
    case description
    case fullUrl
    case date
}
