//
//  BudgetType.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 26/06/24.
//

import Foundation

enum BudgetType : String, CaseIterable, Identifiable, Codable {
    var id: String { return self.rawValue }
    case daily
    case weekly
    case monthly
    case none
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
        case .none:
            return "None"
        }
    }
    
    init?(stringValue: String) {
        switch stringValue {
        case BudgetType.weekly.rawValue:
            self = .weekly
        case BudgetType.monthly.rawValue:
            self = .monthly
        case BudgetType.daily.rawValue:
            self = .daily
        default:
            self = .weekly
        }
    }
}
