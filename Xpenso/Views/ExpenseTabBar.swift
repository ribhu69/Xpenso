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
    var settingsView = SettingsView()
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    @ObservedObject private var appSettings = AppTheme.shared
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
                    
                    settingsView
                        .tabItem {
                            Image("setttingGear", bundle: nil)
                                .renderingMode(.template)
                        }
                    
            }
                .tint(appSettings.selectedColor)
    }
}

