//
//  ExpenseTabBar.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 02/06/24.
//

import SwiftUI

struct ExpenseTabBar : View {
    var expenseListView : ExpenseListView
    var body: some View {
        TabView {
            expenseListView
                .tabItem {
                    Image("home", bundle: nil)
                        .renderingMode(.template)
                }
            
            Kalimba()
                .tabItem {
                    Image("piggy", bundle: nil)
                        .renderingMode(.template)
                }
        }
    }
}

