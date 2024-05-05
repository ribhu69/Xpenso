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

extension ExpenseCategory {
    init?(stringValue: String) {
            switch stringValue {
            case ExpenseCategory.clothing.rawValue:
                self = .clothing
            case ExpenseCategory.diningOut.rawValue:
                self = .diningOut
            case ExpenseCategory.education.rawValue:
                self = .education
            case ExpenseCategory.entertainment.rawValue:
                self = .entertainment
            case ExpenseCategory.groceries.rawValue:
                self = .groceries
            case ExpenseCategory.healthcare.rawValue:
                self = .healthcare
            case ExpenseCategory.housing.rawValue:
                self = .housing
            case ExpenseCategory.miscellaneous.rawValue:
                self = .miscellaneous
            case ExpenseCategory.savings.rawValue:
                self = .savings
            case ExpenseCategory.transportation.rawValue:
                self = .transportation
            case ExpenseCategory.utilities.rawValue:
                self = .utilities
            case ExpenseCategory.none.rawValue:
                self = .none
            default:
                return nil
            }
        }
}
