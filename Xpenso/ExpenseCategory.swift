//
//  ExpenseCategory.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import Foundation

enum ExpenseCategory : String, CaseIterable, Identifiable{
    var id: String { return self.rawValue }
    var itemName : LocalizedStringResource {
        switch self {
        case .clothing:
            return "clothing"
        case .diningOut:
            return "diningOut"
        case .education:
            return "education"
        case .entertainment:
            return "entertainment"
        case .groceries:
            return "groceries"
        case .healthcare:
            return "healthcare"
        case .housing:
            return "housing"
        case .miscellaneous:
            return "miscellaneous"
        case .savings:
            return "savings"
        case .transportation:
            return "transportation"
        case .utilities:
            return "utilities"
        case .none:
            return "none"
        }
    }
    case clothing
    case diningOut
    case education
    case entertainment
    case groceries
    case healthcare
    case housing
    case miscellaneous
    case savings
    case transportation
    case utilities
    case none
}
