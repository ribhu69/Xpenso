//
//  ExpenseService.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import SwiftData


enum OperationError : Error, Equatable {
    case databaseFailure(reason: String)
    case unknownError
}
protocol ExpenseService : AnyObject {
    func addExpense(expense: Expense, completion: @escaping (Int64?) -> Void) 
}

class ExpenseServiceImpl : ExpenseService {

    func addExpense(expense: Expense, completion: @escaping (Int64?) -> Void) {
        //
    }
    
    func getExpenses() async throws -> [Expense] {
        return []
    }
    
    
//    func addExpense(expense: Expense, completion: @escaping (Int64?) -> Void) {
//        guard let connection = DatabaseHelper.shared.getDatabaseInstance() else {
//            Logger.log(.error, "Connection Missing")
//            completion(nil)
//            return
//        }
//        
//        do {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let date = expense.date ?? Date()
//            
//            
//            let rowid = try connection.run(ExpenseDB.table.insert(
//                ExpenseDB.amount <- expense.amount,
//                ExpenseDB.id <- "\(expense.id)",
//                ExpenseDB.description <- expense.description ?? "",
//                ExpenseDB.category <- expense.category.rawValue,
//                ExpenseDB.date <- dateFormatter.string(from: date)
//            ))
//            Logger.log(.info, "Expense Added SuccesFully")
//            completion(rowid)
//        } 
//        catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
//            print("constraint failed: \(message), in \(String(describing: statement))")
//        } catch let error {
//            Logger.log(.error, "ExpenseServiceImpl issue in Add Expense -> \(error)")
//            completion(nil)
//        }
//    }
    
//    func getExpenses() async throws -> [Expense] {
//        guard let connection = DatabaseHelper.shared.getDatabaseInstance() else {
//            Logger.log(.error, "Connection Missing")
//            return []
//        }
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        
//        var expenses = [Expense]()
//        
//        do {
//            for expense in try connection.prepare(ExpenseDB.table) {
//                expenses.append(
//                    Expense(
//                        id: UUID(uuidString: try expense.get(ExpenseDB.id))!,
//                        amount: try expense.get(ExpenseDB.amount),
//                        category: ExpenseCategory(rawValue: try expense.get(ExpenseDB.category))!,
//                        description: try expense.get(ExpenseDB.description),
//                        date: dateFormatter.date(from: try expense.get(ExpenseDB.date)) ?? Date()
//                    )
//                )
//            }
//            return expenses
//        }
//        catch{
//            throw error
//        }
//    }
}
