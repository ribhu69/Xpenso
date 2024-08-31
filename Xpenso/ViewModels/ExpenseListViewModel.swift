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
    var context : ModelContext?
    @Published var expenses : [Expense] = []
    
    init(expenseListService: ExpenseListService, context: ModelContext) {
        self.expenseListService = expenseListService
        self.context = context
        getExpenses()
    }
    
    func addExpense(expense: Expense) {
        guard let context else {return}
        if expenseListService.addExpense(expense: expense, context: context) {
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
        if expenseListService.deleteExpense(expense: expense) {
            if let index = expenses.firstIndex(where: {
                $0.entityId == expense.entityId
            }) {
                expenses.remove(at: index)
            }
            return true
        }
        return false
    }
}
