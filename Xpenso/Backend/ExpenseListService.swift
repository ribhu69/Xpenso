//
//  ExpenseListService.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation

protocol ExpenseListService : AnyObject {
    func getExpenses() -> [Expense]?
}

final class ExpenseListServiceImpl : ExpenseListService {
    func getExpenses() -> [Expense]? {
        guard let connection = DatabaseHelper.shared.getDatabaseInstance() else {
            Logger.log(.fault, "Connection Failed")
            return nil
        }
        
        var results = [Expense]()
        do {
            for expense in try connection.prepare(ExpenseDB.getTable()) {
                let exp = Expense(
                    id: UUID(uuidString: try expense.get(ExpenseDB.id))!,
                    amount: try expense.get(ExpenseDB.amount),
                    category: try ExpenseCategory(rawValue: expense.get(ExpenseDB.category))!,
                    description: try expense.get(ExpenseDB.description),
                    date: try dateFromString(expense.get(ExpenseDB.date))!
                )
                results.append(exp)
            }
            Logger.log(.info, "Fetched Results")
            return results
        }
        
        catch {
            Logger.log(.fault, "Issue with fetch")
            return nil
        }
    }
}
