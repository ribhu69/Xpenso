//
//  Expense.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import Foundation

struct Expense : Identifiable {
    var id = UUID()
    var amount: Double
    var category : ExpenseCategory
    var description: String?
    var date: Date?
}
