//
//  Expense.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import Foundation
import SwiftData

@Model
class Expense : Identifiable {
    var id = UUID()
    var amount: Double
    var category : ExpenseCategory
    var desc: String?
    var date: Date?
    
    init(id: UUID = UUID(), amount: Double, category: ExpenseCategory, description: String? = nil, date: Date? = nil) {
        self.id = id
        self.amount = amount
        self.category = category
        self.desc = description
        self.date = date
    }
}
