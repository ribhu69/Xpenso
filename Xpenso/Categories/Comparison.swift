//
//  Comparison.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import Foundation

enum Comparison : String, CaseIterable, Identifiable {
    var id: String {return self.rawValue}
    var displayValue : LocalizedStringResource {
        switch self {
            
        case .greaterThan:
            return "Greater Than"
        case .greaterThanEqualTo:
            return "Greater Than Or Equal To"
        case .lessThan:
            return "Less Than"
        case .lessThanEqualTo:
            return "Less Than Or Equal To"
        case .equalTo:
            return "Equal To"
        }
    }
    case greaterThan
    case greaterThanEqualTo
    case lessThan
    case lessThanEqualTo
    case equalTo
}
