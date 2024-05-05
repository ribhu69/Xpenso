//
//  Assembler.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation

class ExpenseAssembler {
    static func getExpenseListView() -> ExpenseListView {
        let expenseService : ExpenseListService = ExpenseListServiceImpl()
        let viewModel = ExpenseListViewModel(expenseListService: expenseService)
        let expenseListView = ExpenseListView(viewModel : viewModel)
        return expenseListView
    }
}
