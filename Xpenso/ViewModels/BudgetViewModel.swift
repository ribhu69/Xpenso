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

    @Published var budgets = [Budget]()
    
    init(budgetService: BudgetService, context: ModelContext) {
        self.budgetService = budgetService
        self.context = context
    }
    
    
    func getBudgets() {
        budgets = budgetService.getBudgets()
    }
    
    func addBudget(budget: Budget) {
        
        if budgetService.addBudget(budget: budget) {
            budgets.append(budget)
        }
    }
    
    func updateBudget(budget: Budget) {
        if budgetService.updateBudget(budget: budget) {
            if let index = budgets.firstIndex(where: { temp in
                temp.budgetId == budget.budgetId
            }) {
                budgets[index] = budget
            }
        }
    }
    
    
    func deleteBudget(budget: Budget) -> Bool {
        
        if budgetService.deleteBudget(budget: budget) {
            if let index = budgets.firstIndex(where: { temp in
                temp.budgetId == budget.budgetId
            }) {
                budgets.remove(at: index)
            }
            return true
        }
        return false
    }
    
}
