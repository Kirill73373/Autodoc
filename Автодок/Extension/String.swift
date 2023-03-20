//
//  String.swift
//  Автодок
//
//  Created by Кирилл Блохин on 17.03.2023.
//

import Foundation

extension String {

    func convertDateFormat(old odldDateFotmat: String, new dateFormat: String = "dd.MM.yyyy") -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = odldDateFotmat
        let oldDate = olDateFormatter.date(from: self)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = dateFormat
        return convertDateFormatter.string(from: oldDate ?? Date())
    }
}
