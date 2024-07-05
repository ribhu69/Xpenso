//
//  BudgetStyle.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 26/06/24.
//

import Foundation

enum BudgetStyle : String, CaseIterable, Codable {
    case periodic
    case adhoc
}

extension BudgetStyle {
    init?(stringValue: String) {
        switch stringValue {
        case BudgetStyle.periodic.rawValue:
            self = .periodic
        case BudgetStyle.adhoc.rawValue:
            self = .adhoc
        default:
            self = .periodic
        }
    }
}
