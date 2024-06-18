//
//  BudgetViewModel.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import Combine

class BudgetViewModel : ObservableObject {
    
    var budgetService: BudgetService
    @Published var budget : [Budget] = []
    
    init(budgetService: BudgetService) {
        self.budgetService = budgetService
        getBudgets()
    }
    
    func getBudgets() {
        budget = budgetService.getBudgets()
    }
    
    func addBudget(budget: Budget) {
        budgetService.addBudget(budget: budget)
    }
    
//    func deleteExpense(expense: Expense) -> Bool {
//        expenseListService.deleteExpense(expense: expense)
//    }
}
