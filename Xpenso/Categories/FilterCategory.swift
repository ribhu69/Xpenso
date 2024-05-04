//
//  FilterCategory.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import Foundation

enum FilterCategory : String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    case expenseType
    case date
    case searchKeyWord
}
