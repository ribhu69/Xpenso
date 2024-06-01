//
//  DateExtensions.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation


func formattedDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium

    return dateFormatter.string(from: date)
}

func dateFromString(_ dateString: String) -> Date? {
    
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    return dateFormatter.date(from: dateString)
}


