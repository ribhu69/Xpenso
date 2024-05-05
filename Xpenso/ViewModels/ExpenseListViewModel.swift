//
//  ExpenseListViewModel.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import Combine

class ExpenseListViewModel : ObservableObject {
    
    var expenseListService: ExpenseListService
    @Published var expenses : [Expense] = []
    
    init(expenseListService: ExpenseListService) {
        self.expenseListService = expenseListService
        getExpenses()
    }
    
    func getExpenses() {
        if let expenseList = expenseListService.getExpenses() {
           expenses = expenseList
        }
    }
}
