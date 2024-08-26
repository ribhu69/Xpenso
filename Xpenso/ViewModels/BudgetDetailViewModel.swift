//
//  BudgetDetailViewModel.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 07/07/24.
//

import Foundation
import SwiftData

class BudgetDetailViewModel {
    
    private var expenseService: ExpenseService
    private var budgetService: BudgetService
    @Published var relatedExpenses = [Expense]()
    init(budget: Budget,context: ModelContext) {
        
        
        let expenseService : ExpenseService = ExpenseServiceImpl()
        self.expenseService = expenseService
        let budgetService : BudgetService = BudgetServiceImpl()
        self.budgetService = budgetService
        
        Task {
            await getRelatedExpenses(budget: budget)
        }
        
    }
    
    func getRelatedExpenses(budget: Budget) async {
        do {
            relatedExpenses = try await self.expenseService.getExpenses(budget: budget)
        }
        catch {
            print(error)
        }
    }
    
    func addExpense(expense: Expense) async -> Bool {
        return await self.expenseService.addExpense(expense: expense)
    }
    
    func deleteExpense(expense: Expense) async -> Bool {
        return await self.expenseService.deleteExpense(expense: expense)
    }
}
