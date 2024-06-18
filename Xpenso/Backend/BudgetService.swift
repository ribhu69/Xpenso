//
//  BudgetService.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 18/06/24.
//

import Foundation
import SQLite
import SQLite3

protocol BudgetService {
    func getBudgets() -> [Budget]
    func addBudget(budget: Budget) -> Int64?
}

class BudgetServiceImpl : BudgetService {
    func getBudgets() -> [Budget] {
        return []
    }
    
    func addBudget(budget: Budget) -> Int64? {
        guard let connection = DatabaseHelper.shared.getDatabaseInstance() else {
            Logger.log(.fault, "Connection Failed")
            return nil
        }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let startDate = budget.startDate
            let endDate = budget.endDate
            
            
            let rowid = try connection.run(BudgetDB.table.insert(
                BudgetDB.amount <- budget.amount,
                BudgetDB.id <- "\(budget.id)",
                BudgetDB.startDate <- dateFormatter.string(from: startDate),
                BudgetDB.endDate <- dateFormatter.string(from: endDate),
                BudgetDB.budgetTitle <- budget.budgetTitle,
                BudgetDB.budgetType <- budget.budgetType.rawValue
            ))
            Logger.log(.info, "Expense Added SuccesFully")
            return rowid
        }
        catch (let error) {
            print(error)
            return nil
        }
//        catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
//            print("constraint failed: \(message), in \(String(describing: statement))")
//            return nil
//        }
    }
    

}
