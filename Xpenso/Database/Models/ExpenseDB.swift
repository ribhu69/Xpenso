//
//  ExpenseDB.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import SQLite

class ExpenseDB {
    static let table = Table("Expense")
    static let id = Expression<String>("id")
    static let amount = Expression<Double>("amount")
    static let description = Expression<String?>("description")
    static let date = Expression<String>("date")
    static let category = Expression<String>("category")
    
    
    static func getParams() -> [Any]{
        return [id,amount,description,date,category]
    }
    static func getTable() -> Table {
        return table
    }
}
