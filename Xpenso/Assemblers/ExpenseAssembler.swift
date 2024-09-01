//
//  Assembler.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import SwiftData

class ExpenseAssembler {
    static func getTabBar(context: ModelContext) -> ExpenseTabBar {
        let expenseService : ExpenseListService = ExpenseListServiceImpl()
        let expenseViewModel = ExpenseListViewModel(expenseListService: expenseService, context: context)
        let expenseListView = ExpenseListView(viewModel : expenseViewModel)
        
        let budgetService : BudgetService = BudgetServiceImpl()
        let budgetViewModel = BudgetViewModel(budgetService: budgetService, context: context)
//        let budgetView = BudgetView(viewModel : budgetViewModel)
        
        let budgetView = BudgetView(viewModel : budgetViewModel)
        
        return ExpenseTabBar(expenseListView: expenseListView, budgetView: budgetView)
    }
    
}
