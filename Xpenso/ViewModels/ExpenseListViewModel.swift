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
//        getBudgets()
    }
    
    
    func getBudgets() {
        Logger.log(.info, #function)
        budgets = budgetService.getAdhocBudgets()
    }
    
    func addBudget(budget: Budget) {
        if budgetService.addBudget(budget: budget) {
            
            budgets.append(budget)

        }
    }
    
    
    func deleteBudget(budget: Budget) -> Bool {
        
        if budgetService.deleteBudget(budget: budget) {
            if let index = budgets.firstIndex(where: { temp in
                temp.id == budget.id
            }) {
                budgets.remove(at: index)
            }
            return true
        }
        return false
    }
    
}
