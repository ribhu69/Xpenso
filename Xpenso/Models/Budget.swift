//
//  Budget.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 18/06/24.
//

import Foundation
import SwiftData

@Model
final class Budget : Identifiable {
    var budgetId : String
    var amount: Double
    var budgetTitle: String
    /// used to store budgetType rawValue in Swift data
    var budget_type: String
    /// used to store budgetStyle rawValue in Swift data
    var budget_style : String
    @Transient var budgetType : BudgetType = BudgetType(rawValue: "none")!
    @Transient var budgetStyle : BudgetStyle = BudgetStyle(rawValue: "adhoc")!
    var startDate : Date?
    
    var endDate: Date? {
        
        guard let startDate else {return nil}
            switch budgetType {
            case .daily:
                return Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
            case .weekly:
                return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startDate)!
            case .monthly:
                return Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
            default:
                return nil
            }
        }
    init(id: String, amount: Double, budgetTitle: String, budgetType: BudgetType, budgetStyle: BudgetStyle, startDate: Date? = nil) {
        self.budgetId = id
        self.amount = amount
        self.budgetTitle = budgetTitle
        self.budgetType = budgetType
        self.budget_type = budgetType.rawValue
        self.budgetStyle = budgetStyle
        self.budget_style = budgetStyle.rawValue

        self.startDate = startDate
        
    }
}



extension Budget {
   
    static func singularBudgetSample() -> Budget {
        Budget(id: UUID().uuidString, amount: 100, budgetTitle: "My Sample Budget", budgetType: .weekly, budgetStyle: .adhoc, startDate: Date())
//        Budget(amount: 100, budgetTitle: , budgetType: .weekly, budgetStyle: .periodic, startDate: Date())
    }
    
    static func sampleBudgets() -> [Budget] {
           return [
            Budget(id: UUID().uuidString, amount: 100, budgetTitle: "Budget 1", budgetType: .daily, budgetStyle: .periodic, startDate: Date()),
            Budget(id: UUID().uuidString, amount: 200, budgetTitle: "Budget 2", budgetType: .weekly, budgetStyle: .adhoc, startDate: Date()),
            Budget(id: UUID().uuidString, amount: 300, budgetTitle: "Budget 3", budgetType: .monthly, budgetStyle: .periodic, startDate: Date()),
            Budget(id: UUID().uuidString, amount: 150, budgetTitle: "Budget 4", budgetType: .none, budgetStyle: .adhoc, startDate: Date()),
            Budget(id: UUID().uuidString, amount: 250, budgetTitle: "Budget 5", budgetType: .daily, budgetStyle: .periodic, startDate: Date()),
            Budget(id: UUID().uuidString, amount: 350, budgetTitle: "Budget 6", budgetType: .weekly, budgetStyle: .adhoc, startDate: Date()),
            Budget(id: UUID().uuidString, amount: 400, budgetTitle: "Budget 7", budgetType: .monthly, budgetStyle: .periodic, startDate: Date()),
            Budget(id: UUID().uuidString, amount: 450, budgetTitle: "Budget 8", budgetType: .none, budgetStyle: .adhoc, startDate: Date()),
            Budget(id: UUID().uuidString, amount: 500, budgetTitle: "Budget 9", budgetType: .daily, budgetStyle: .periodic, startDate: Date()),
            Budget(id: UUID().uuidString, amount: 550, budgetTitle: "Budget 10", budgetType: .weekly, budgetStyle: .adhoc, startDate: Date())
           ]
       }

}
