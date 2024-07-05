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
    var id = UUID()
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
    init(id: UUID = UUID(), amount: Double, budgetTitle: String, budgetType: BudgetType, budgetStyle: BudgetStyle, startDate: Date? = nil) {
        self.id = id
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
        Budget(amount: 100, budgetTitle: "My Sample Budget", budgetType: .weekly, budgetStyle: .periodic, startDate: Date())
    }

}
