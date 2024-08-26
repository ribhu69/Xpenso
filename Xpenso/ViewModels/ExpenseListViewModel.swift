//
//  BudgetViewModel.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import Combine
import SwiftData

class BudgetViewModel : ObservableObject {
    
    var budgetService: BudgetService
    var context: ModelContext?
    @Published var periodicBudgets : [Budget] = []
    @Published var adhocBudget : [Budget] = []
    
    init(budgetService: BudgetService, context: ModelContext) {
        self.budgetService = budgetService
        self.context = context
        getBudgets()
    }
    
    
    func getBudgets() {
        Logger.log(.info, #function)
        periodicBudgets = budgetService.getPeriodicBudgets()
        adhocBudget = budgetService.getAdhocBudgets()
    }
    
    func addBudget(budget: Budget) {
        if budgetService.addBudget(budget: budget) {
            switch budget.budgetStyle {
            case .periodic:
                periodicBudgets.append(budget)
            case .adhoc:
                adhocBudget.append(budget)
            }
        }
    }
    
    
    func deleteBudget(budget: Budget) -> Bool {
        
        if budgetService.deleteBudget(budget: budget) {
            if let index = periodicBudgets.firstIndex(where: { temp in
                temp.id == budget.id
            }) {
                periodicBudgets.remove(at: index)
            }
            
            if let index = adhocBudget.firstIndex(where: { temp in
                temp.id == budget.id
            }) {
                adhocBudget.remove(at: index)
            }
            return true
        }
        return false
        
    }
    
//    func deleteExpense(expense: Expense) -> Bool {
//        expenseListService.deleteExpense(expense: expense)
//    }
}
