//
//  Budget.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 18/06/24.
//

import Foundation

struct Budget : Identifiable {
    var id = UUID()
    var amount: Double
    var budgetTitle: String

    var budgetType : BudgetType
    var startDate : Date
    
    var endDate: Date {
            switch budgetType {
            case .daily:
                return Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
            case .weekly:
                return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startDate)!
            case .monthly:
                return Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
            }
        }
    
    init(title: String, amount: Double, budgetType: BudgetType, startDate: Date = Date()) {
        self.budgetTitle = title
        self.amount = amount
        self.budgetType = budgetType
        self.startDate = startDate
    }
}



extension Budget {
    static func sampleBudgets() -> [Budget] {
        return [
            Budget(title: "Groceries", amount: 100.0, budgetType: .daily, startDate: Date()),
            Budget(title: "Transport", amount: 500.0, budgetType: .weekly, startDate: Date()),
            Budget(title: "Rent", amount: 2000.0, budgetType: .monthly, startDate: Date()),
            Budget(title: "Dining Out", amount: 150.0, budgetType: .daily, startDate: Date()),
            Budget(title: "Entertainment", amount: 300.0, budgetType: .weekly, startDate: Date()),
            Budget(title: "Savings", amount: 1000.0, budgetType: .monthly, startDate: Date()),
            Budget(title: "Coffee", amount: 80.0, budgetType: .daily, startDate: Date()),
            Budget(title: "Utilities", amount: 400.0, budgetType: .weekly, startDate: Date()),
            Budget(title: "Vacation Fund", amount: 2500.0, budgetType: .monthly, startDate: Date()),
            Budget(title: "Fitness", amount: 200.0, budgetType: .daily, startDate: Date())
        ]
    }
}
