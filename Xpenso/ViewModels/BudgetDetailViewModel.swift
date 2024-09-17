//
//  BudgetDetailViewModel.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 07/07/24.
//

import Foundation
import SwiftData

class BudgetDetailViewModel : ObservableObject {
    
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
        if await self.expenseService.addExpense(expense: expense) {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.relatedExpenses.append(expense)
            }
        }
        return true
    }
    
    func deleteExpense(expense: Expense) async -> Bool {
        let result = await self.expenseService.deleteExpense(expense: expense)
        if result, let index = relatedExpenses.firstIndex(where: { element in
                element.id == expense.id
            }) {
            relatedExpenses.remove(at: index)
            return true
        }
        return false
    }
}
