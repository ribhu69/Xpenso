//
//  ExpenseTabBar.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 02/06/24.
//

import SwiftUI

struct ExpenseTabBar : View {
    var expenseListView : ExpenseListView
    var budgetView : BudgetView
    var body: some View {
        NavigationView {
            TabView {
                expenseListView
                    .tabItem {
                        Image("home", bundle: nil)
                            .renderingMode(.template)
                    }
                
                budgetView
                    .tabItem {
                        Image("budget", bundle: nil)
                            .renderingMode(.template)
                    }
            }
        }
    }
}

