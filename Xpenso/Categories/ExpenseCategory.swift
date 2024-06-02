//
//  ExpenseCategory.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import Foundation
import Charts
import SwiftUI

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
    var dynamicColor: DynamicColor {
            switch self {
            case .clothing:
                return DynamicColor(lightHex: "#FF5733", darkHex: "#CC4626") // Orange / Darker Orange
            case .diningOut:
                return DynamicColor(lightHex: "#C70039", darkHex: "#99002B") // Red / Darker Red
            case .education:
                return DynamicColor(lightHex: "#900C3F", darkHex: "#70082F") // Dark Red / Darker Dark Red
            case .entertainment:
                return DynamicColor(lightHex: "#FFC300", darkHex: "#CC9A00") // Yellow / Darker Yellow
            case .groceries:
                return DynamicColor(lightHex: "#DAF7A6", darkHex: "#A9D98B") // Light Green / Darker Light Green
            case .healthcare:
                return DynamicColor(lightHex: "#FF5733", darkHex: "#CC4626") // Coral / Darker Coral
            case .housing:
                return DynamicColor(lightHex: "#581845", darkHex: "#3F1133") // Dark Purple / Darker Dark Purple
            case .miscellaneous:
                return DynamicColor(lightHex: "#2ECC71", darkHex: "#27A55A") // Green / Darker Green
            case .savings:
                return DynamicColor(lightHex: "#1ABC9C", darkHex: "#12897E") // Teal / Darker Teal
            case .transportation:
                return DynamicColor(lightHex: "#3498DB", darkHex: "#2874A6") // Blue / Darker Blue
            case .utilities:
                return DynamicColor(lightHex: "#9B59B6", darkHex: "#784796") // Purple / Darker Purple
            case .none:
                return DynamicColor(lightHex: "#BDC3C7", darkHex: "#8A9A9F") // Silver / Darker Silver
            }
        }
        
    func color(for scheme: ColorScheme) -> Color {
        return dynamicColor.color(for: scheme)
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

extension ExpenseCategory : Plottable {
    
}
