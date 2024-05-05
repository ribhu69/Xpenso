//
//  ExpenseService.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import SQLite
import SQLite3

enum OperationError : Error, Equatable {
    case databaseFailure(reason: String)
    case unknownError
}
protocol ExpenseService : AnyObject {
    func addExpense(expense: Expense, completion: @escaping (Int64?) -> Void) 
}

class ExpenseServiceImpl : ExpenseService {

    func addExpense(expense: Expense, completion: @escaping (Int64?) -> Void) {
        guard let connection = DatabaseHelper.shared.getDatabaseInstance() else {
            Logger.log(.error, "Connection Missing")
            completion(nil)
            return
        }
        
        do {
            let rowid = try connection.run(ExpenseDB.users.insert(
                ExpenseDB.amount <- expense.amount,
                ExpenseDB.id <- "\(expense.id)",
                ExpenseDB.description <- expense.description ?? "", // Use nil coalescing to handle nil description
                ExpenseDB.category <- expense.category.rawValue, // Use nil coalescing to handle nil description
                ExpenseDB.date <- formattedDate(date: expense.date ?? Date()) // Use nil coalescing and default value for date
            ))
            Logger.log(.info, "Expense Added SuccesFully")
            completion(rowid)
        } 
        catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("constraint failed: \(message), in \(String(describing: statement))")
        } catch let error {
            Logger.log(.error, "ExpenseServiceImpl issue in Add Expense ")
            completion(nil)
        }
    }

}
