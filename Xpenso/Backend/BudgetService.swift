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
    
    func getBudgets() -> [Budget]
    func addBudget(budget: Budget) -> Bool
    func editBudget(budget: Budget) -> Bool
    func deleteBudget(budget: Budget) -> Bool
    
    func updateBudget(budget: Budget) -> Bool
}

class BudgetServiceImpl : BudgetService {
    func editBudget(budget: Budget) -> Bool {
        
        let context = DatabaseHelper.shared.getModelContext()
        let budgetId = budget.id
        let predicate = #Predicate<Budget> { $0.id == budgetId}
        let periodicBudgetPredicate = FetchDescriptor<Budget>(predicate: predicate)
        do {
            var periodics = try context.fetch(periodicBudgetPredicate)
            periodics[0] = budget
            
            return true
        }
        catch {
            print(error)
            return false
        }
    }
    
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
//            Logger.log(.error, error)
            return []
        }
    
    }
    
    func getBudgets() -> [Budget] {
        let context = DatabaseHelper.shared.getModelContext()
        
        let fetchDescriptor = FetchDescriptor<Budget>()
        do {
            let periodics = try context.fetch(fetchDescriptor)
            Logger.log(.info, "Periodics count : \(periodics.count)")
            return periodics
        }
        catch {
            print(error)
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
        let context = DatabaseHelper.shared.getModelContext()
        context.delete(budget)
        return true
    }
    
    func updateBudget(budget: Budget) -> Bool {
        
        let context = DatabaseHelper.shared.getModelContext()
        
        let budgetId = budget.budgetId
        let predicate = #Predicate<Budget> { $0.budgetId == budgetId}
        let fetchDesc = FetchDescriptor<Budget>(predicate: predicate)
        do {
            let expenses = try context.fetch(fetchDesc)
            for item in expenses {
                item.budgetTitle = budget.budgetTitle
                item.amount = budget.amount
                item.startDate = budget.startDate
                item.budget_type = budget.budget_type
                item.budget_style = budget.budget_style
            }
            try context.save()
            return true
        }
        catch {
            Logger.log(.error, error.localizedDescription)
            return false
        }
    }
}
