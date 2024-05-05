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
    dateFormatter.dateFormat = "MMM d, yyyy"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set locale to ensure consistent date parsing

    return dateFormatter.date(from: dateString)
}
