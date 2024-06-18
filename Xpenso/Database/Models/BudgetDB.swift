//
//  Budget.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 18/06/24.
//

import Foundation
import SQLite

enum BudgetType : String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    case daily
    case weekly
    case monthly
}

extension BudgetType {
    
    var displayValue : LocalizedStringResource {
        switch self {
            
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        }
    }
}

class BudgetDB {
    static let table = Table("Budget")
    static let id = Expression<String>("id")
    static let budgetTitle = Expression<String>("budgetTitle")
    static let amount = Expression<Double>("amount")
    static let budgetType = Expression<String?>("budgetType")
    static let startDate = Expression<String>("startDate")
    static let endDate = Expression<String>("endDate")

    
    static func getParams() -> [Any]{
        return [id,budgetTitle, amount,budgetType, startDate, endDate]
    }
    static func getTable() -> Table {
        return table
    }
}
