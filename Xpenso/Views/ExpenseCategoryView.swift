//
//  ExpenseCategoryView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import SwiftUI


struct ExpenseCategoryView : View {
    @Binding var expenseType : ExpenseCategory
    @Binding var isPresented: Bool
    var body: some View {
            VStack {
                
               
                List {
                    ForEach(ExpenseCategory.allCases, id: \.id) { item in
                       ExpenseCategoryRow(expense: item)
                        .onTapGesture {
                            self.expenseType = item
                            isPresented = false
                        }
                    }
                    
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(.plain)
            }
    }
}

struct ExpenseCategoryRow : View {
    @Environment(\.colorScheme) var colorScheme

    var expense: ExpenseCategory
    var body: some View {
        HStack {
            Image(expense.rawValue, bundle: nil)
                .renderingMode(.template)
                .foregroundStyle(expense.color(for: colorScheme))
            Text(expense.itemName)
        }
        .padding(.vertical, 8)
    }
}

struct ExpenseCategoryView_PV: PreviewProvider {
    static var previews: some View {
        ExpenseCategoryView(expenseType: .constant(.miscellaneous), isPresented: .constant(true))
    }
}
