//
//  ExpenseListViewModel.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import Combine
import SwiftData

class ExpenseListViewModel : ObservableObject {
    
    var expenseListService: ExpenseListService
    @Published var expenses : [Expense] = []
    
    init(expenseListService: ExpenseListService) {
        self.expenseListService = expenseListService
        getExpenses()
    }
    
    func removeAllExpenses() {
        expenses.removeAll()
    }
    func addExpense(expense: Expense) {
        if expenseListService.addExpense(expense: expense) {
            expenses.append(expense)
        }
        else {
            Logger.log(.error, "Failed to add expense")
        }
    }
  
    
    func getExpenses() {
        if let expenseList = expenseListService.getExpenses() {
           expenses = expenseList
        }
    }
    
    func deleteExpense(expense: Expense) -> Bool {
        if expenseListService.deleteExpense(expense: expense),
           let index = expenses.firstIndex(where: {
                $0.entityId == expense.entityId
            }) {
                expenses.remove(at: index)
            return true
            }
        return false
    }
}
