//
//  DatetimeUtils.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import Foundation

func formatDatetime(_ datetime: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    guard let date = dateFormatter.date(from: datetime) else {
        return datetime
    }
    
    let currentDate = Date()
    let calendar = Calendar.current
    
    if calendar.isDateInToday(date) {
        dateFormatter.dateFormat = "HH:mm"
    } else {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    return dateFormatter.string(from: date)
}
