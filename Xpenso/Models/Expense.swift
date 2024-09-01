//
//  Expense.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import Foundation
import SwiftData

@Model
final class Expense : Identifiable {
    var entityId : String
    var amount: Double
    var category : ExpenseCategory
    var desc: String?
    var date: Date?
    var associatedBudget : Budget?
    
    init(id: String, amount: Double, category: ExpenseCategory, description: String? = nil, date: Date? = nil) {
        self.entityId = id
        self.amount = amount
        self.category = category
        self.desc = description
        self.date = date
    }
}

extension Expense {
    static var singleExpense = Expense(id: UUID().uuidString, amount: 2500, category: .clothing, description: "This is a sample description", date: Date())
}
