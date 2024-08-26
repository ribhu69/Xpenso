//
//  ExpenseTabBar.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 02/06/24.
//

import SwiftUI

struct ExpenseTabBar : View {
    var expenseListView : ExpenseListView
    var budgetView : BudgetV2View
    var body: some View {
            
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

