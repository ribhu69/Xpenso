//
//  AddBudgetViewX.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 06/06/24.
//

import SwiftUI

struct AddBudgetViewX : View {
    var body: some View {
        TabView {
            AddBudgetView()
            AddBudgetView()
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        
    }
}

