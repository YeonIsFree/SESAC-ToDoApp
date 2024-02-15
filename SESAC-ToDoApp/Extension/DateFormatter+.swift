//
//  DateFormatter+.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import Foundation

extension DateFormatter {
    static func convertDateToString(_ raw: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        guard let rawDate = formatter.date(from: raw) else { return "ERROR" }
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: rawDate)
    }
}
