//
//  BudgetService.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 18/06/24.
//

import Foundation
import SwiftData

protocol BudgetService {
    func getPeriodicBudgets() -> [Budget]
    func getAdhocBudgets() -> [Budget]
    func addBudget(budget: Budget) -> Bool
    func deleteBudget(budget: Budget) -> Bool
}

class BudgetServiceImpl : BudgetService {
    func getPeriodicBudgets() -> [Budget] {
        
        let context = DatabaseHelper.shared.getModelContext()
        
        let predicate = #Predicate<Budget> { $0.budget_style == "periodic"}
        let periodicBudgetPredicate = FetchDescriptor<Budget>(predicate: predicate)
        do {
            let periodics = try context.fetch(periodicBudgetPredicate)
            Logger.log(.info, "Periodics count : \(periodics.count)")
            return periodics
        }
        catch {
            print(error)
            print("ZXCV: \(predicate)")
//            Logger.log(.error, error)
            return []
        }
    
    }
    
    func getAdhocBudgets() -> [Budget] {
        let context = DatabaseHelper.shared.getModelContext()

        let predicate = #Predicate<Budget> { $0.budget_style == "adhoc"}
        let adhocBudgetPredicate = FetchDescriptor<Budget>(predicate: predicate)
        do {
            let adhocs = try context.fetch(adhocBudgetPredicate)
            return adhocs
        }
        catch {
            Logger.log(.error, #function)
            return []
        }
    
    }
    
    func addBudget(budget: Budget) -> Bool {
        let context = DatabaseHelper.shared.getModelContext()
        context.insert(budget)
        return true
    }
    
    func deleteBudget(budget: Budget) -> Bool {
        return true
    }
}

//class BudgetServiceImpl : BudgetService {
//    
//    func getAdhocBudgets() -> [Budget] {
//        guard let connection = DatabaseHelper.shared.getDatabaseInstance() else {
//            Logger.log(.fault, "Connection Failed")
//            fatalError()
//        }
//        
//        var results = [Budget]()
//        return results
////        do {
////            
////            let query = BudgetDB.table.filter(BudgetDB.budgetStyle == "adhoc")
////            for budget in try connection.prepare(query) {
////                
////                let budget = Budget(
////                    id: UUID(uuidString: try budget.get(ExpenseDB.id))!,
////                    amount: try budget.get(BudgetDB.amount),
////                    budgetTitle: try budget.get(BudgetDB.budgetTitle),
////                    budgetType:  try BudgetType(rawValue: budget.get(BudgetDB.budgetType)!)!,
////                    budgetStyle:  try BudgetStyle(rawValue: budget.get(BudgetDB.budgetStyle)!)!,
////                    startDate:  try dateFromString(budget.get(BudgetDB.startDate))
////                )
////                results.append(budget)
////
////            }
////            Logger.log(.info, "Fetched Results")
////            return results
////        }
////        
////        catch {
////            Logger.log(.fault, "Issue with fetch")
////            fatalError()
////        }
//    }
//    
//    func getPeriodicBudgets() -> [Budget] {
//        guard let connection = DatabaseHelper.shared.getDatabaseInstance() else {
//            Logger.log(.fault, "Connection Failed")
//            fatalError()
//        }
//        
//        var results = [Budget]()
//        return results
////        do {
////            let query = BudgetDB.table.filter(BudgetDB.budgetStyle == "periodic")
////
////            for budget in try connection.prepare(query) {
////                
////                let startDate = try budget.get(BudgetDB.startDate)
////                let budget = Budget(
////                    id: UUID(uuidString: try budget.get(ExpenseDB.id))!,
////                    amount: try budget.get(BudgetDB.amount),
////                    budgetTitle: try budget.get(BudgetDB.budgetTitle),
////                    budgetType:  try BudgetType(rawValue: budget.get(BudgetDB.budgetType)!)!,
////                    budgetStyle:  try BudgetStyle(rawValue: budget.get(BudgetDB.budgetStyle)!)!,
////                    startDate:  !startDate.isEmpty ? dateFromString(startDate) : nil)
////                
////                results.append(budget)
////
////            }
////            Logger.log(.info, "Fetched Results")
////            return results
////        }
////        
////        catch {
////            Logger.log(.fault, "Issue with fetch")
////            fatalError()
////        }
//    }
//    
//    func addBudget(budget: Budget) -> Int64? {
//        guard let connection = DatabaseHelper.shared.getDatabaseInstance() else {
//            Logger.log(.fault, "Connection Failed")
//            return nil
//        }
//        
//        do {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let startDate = budget.startDate ?? nil
//            let endDate = budget.endDate ?? nil
//            
//            
//            let rowid = try connection.run(BudgetDB.table.insert(
//                BudgetDB.amount <- budget.amount,
//                BudgetDB.id <- "\(budget.id)",
//                BudgetDB.startDate <- startDate != nil ? dateFormatter.string(from: startDate!) : "",
//                BudgetDB.endDate <- endDate != nil ? dateFormatter.string(from: startDate!) : "",
//                BudgetDB.budgetTitle <- budget.budgetTitle,
//                BudgetDB.budgetType <- budget.budgetType.rawValue,
//                BudgetDB.budgetStyle <- budget.budgetStyle.rawValue
//            ))
//            Logger.log(.info, "Expense Added SuccesFully")
//            return rowid
//        }
//        catch (let error) {
//            print(error)
//            return nil
//        }
//    }
//    
//    func deleteBudget(budget: Budget) -> Bool {
//        guard let connection = DatabaseHelper.shared.getDatabaseInstance() else {
//            Logger.log(.fault, "Connection Failed")
//            return false
//        }
//        
//        do {
//            let table = BudgetDB.table
//            let filter = BudgetDB.table.filter(BudgetDB.id == budget.id.uuidString)
//            
//            if try connection.run(filter.delete()) > 0 {
//                Logger.log(.info, "Delete successful")
//                return true
//            }
//            else {
//                Logger.log(.error, "Delete not successful")
//                return false
//            }
//        }
//        catch {
//            Logger.log(.error, "Error deleting expense")
//            return false
//        }
//    }
//}
