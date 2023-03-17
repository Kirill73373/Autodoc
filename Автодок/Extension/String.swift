//
//  String.swift
//  Автодок
//
//  Created by Кирилл Блохин on 17.03.2023.
//

import Foundation

extension String {
    
    func convertDateFormat() -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let oldDate = olDateFormatter.date(from: self)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd.MM.yyyy"
        return convertDateFormatter.string(from: oldDate ?? Date())
    }
}
