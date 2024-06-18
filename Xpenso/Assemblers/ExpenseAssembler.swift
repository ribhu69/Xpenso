//
//  Assembler.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation

class ExpenseAssembler {
    static func getTabBar() -> ExpenseTabBar {
        let expenseService : ExpenseListService = ExpenseListServiceImpl()
        let viewModel = ExpenseListViewModel(expenseListService: expenseService)
        let expenseListView = ExpenseListView(viewModel : viewModel)
        
        let budgetService : BudgetService = BudgetServiceImpl()
        let budgetViewModel = BudgetViewModel(budgetService: budgetService)
        let budgetView = BudgetView(viewModel : budgetViewModel)
        
        return ExpenseTabBar(expenseListView: expenseListView, budgetView: budgetView)
    }
}
