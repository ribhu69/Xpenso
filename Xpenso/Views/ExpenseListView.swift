//
//  ExpenseListView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import SwiftUI

struct ExpenseListView : View {
    
    
    @State var filterByCategory = false
    @State var isCategorySelectorVisible = false
    @State var expenseType : ExpenseCategory = .none
    
    @State var filterByExpense = false
    @State var isExpenseComparatorVisible = false
    @State var comparisonType : Comparison = .equalTo
    @State var comparisonValue : String = ""
    
    
    
    @State var addExpense : Bool = false
    @State var addFilter : Bool = false
    @State var showGraph : Bool = false
    @State var filterCount : Int = 0
    
    @ObservedObject var viewModel : ExpenseListViewModel
    
    
    @State var filteredExpenses : [Expense] = []
    var body: some View {
        NavigationView {
            VStack {
                
                if filterCount > 0 {
                    
                    if filteredExpenses.isEmpty {
                        Image("emptyView", bundle: nil)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 50, height: 50)
                        Text("No Expenses Found for Applied Filter")
                            .font(.body)
                    }
                    
                    else {
                        
                        List {
                            ForEach(filteredExpenses, id: \.id) { expense in
                                ExpenseRow(expense: expense)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            deleteExpense(expense)
                                        } label: {
                                            Image("delete", bundle: nil)
                                                .renderingMode(.template) // Apply rendering mode
                                        }
                                    }
                            } .listRowSeparator(.hidden)
                        }.listStyle(.plain)
                    }
                }
                else {
                    if viewModel.expenses.isEmpty {
                        Image("emptyView", bundle: nil)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 50, height: 50)
                        Text("No Expenses Found")
                            .font(.body)
                        
                        Button(action: {
                            addExpense = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Add Expense")
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 1)
                                    .foregroundStyle(Color.clear)
                                
                            }
                            
                        }
                        .sheet(isPresented: $addExpense, content: {
                            NavigationView {
                                
                                AddExpenseView(isAddExpense: $addExpense) { newExpense in
                                    viewModel.expenses.append(newExpense)
                                }
                                .navigationTitle("Add Expense")
                            }
                        })
                    }
                    else {
                        List {
                            ForEach(viewModel.expenses, id: \.id) { expense in
                                ExpenseRow(expense: expense)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            deleteExpense(expense)
                                        } label: {
                                            Image("delete", bundle: nil)
                                                .renderingMode(.template) // Apply rendering mode
                                        }
                                    }
                            } .listRowSeparator(.hidden)
                        }.listStyle(.plain)
                        
                        VStack {
                            Divider()
                                .background(.gray)
                    
                            HStack {
                                Text("Total:")
                                    .font(.title2)
                                Text(viewModel.expenses.reduce(0) { $0 + $1.amount }, format: .currency(code: "INR"))
                                    .font(.title2)
                                    .padding(.leading, 8)
                                
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            .toolbar {
                if !viewModel.expenses.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            
                            Button(action: {
                                showGraph = true
                            }) {
                                
                                    Image("charts")
                                        .renderingMode(.template)
                                
                            }
                            
                            
                            Button(action: {
                                addFilter = true
                            }) {
                                
                                if filterCount > 0 {
                                    CustomLabel( badgeCount: filterCount)
                                }
                                else {
                                    Image("filter")
                                        .renderingMode(.template)
                                }
                            }
                            Button(action: {
                                addExpense = true
                            }) {
                                Image("plus")
                                    .renderingMode(.template)
                                
                            }
                        }
                    }
                }
            }
            
            .sheet(isPresented: $showGraph, content: {
                NavigationView {
                    ChartView(expenses: viewModel.expenses)
                }
            })
            
            .sheet(isPresented: $addExpense, content: {
                NavigationView {
                    AddExpenseView(isAddExpense: $addExpense) { newExpense in
                        viewModel.expenses.append(newExpense)
                    }
                    .navigationTitle("Add Expense")
                }
            })
            
            .sheet(isPresented: $addFilter,
                   content: {
                NavigationView {
                    
                    FilterView(
                        isFilterViewVisible: $addFilter,
                        filterByCategory: $filterByCategory,
                        isCategorySelectorVisible: $isCategorySelectorVisible,
                        expenseType: $expenseType,
                        filterByExpense: $filterByExpense,
                        isExpenseComparatorVisible: $isExpenseComparatorVisible,
                        comparisonType: $comparisonType,
                        comparisonValue: $comparisonValue,
                        filterCount: $filterCount
                    )
                    .navigationTitle("Filter By")
                    
                    //                    FilterView(appliedFilters: $filterCount)
                    //                        .navigationTitle("Filter By")
                }
            })
            .onChange(of: addFilter) { oldValue, newValue in
                if newValue == false {
                    if filterCount == 2{
                        var newValues = [Expense]()
                        
                        newValues = viewModel.expenses.filter { comparison in
                            switch comparisonType {
                            case .greaterThan:
                                return comparison.amount > Double(comparisonValue)!
                            case .greaterThanEqualTo:
                                return comparison.amount >= Double(comparisonValue)!
                            case .lessThan:
                                return comparison.amount < Double(comparisonValue)!
                            case .lessThanEqualTo:
                                return comparison.amount <= Double(comparisonValue)!
                            case .equalTo:
                                return comparison.amount == Double(comparisonValue)!
                            }
                        }
        
                        
                        if expenseType != .none {
                            newValues = newValues.filter {
                                item in
                                
                                item.category == expenseType
                            }
                        }
                        
                        filteredExpenses = newValues
                        
                        
                    }
                    else if filterCount == 1 {
                        var newValues = [Expense]()
                        if filterByExpense && !comparisonValue.isEmpty {
                            
                            
                            newValues = viewModel.expenses.filter { comparison in
                                switch comparisonType {
                                case .greaterThan:
                                    return comparison.amount > Double(comparisonValue)!
                                case .greaterThanEqualTo:
                                    return comparison.amount >= Double(comparisonValue)!
                                case .lessThan:
                                    return comparison.amount < Double(comparisonValue)!
                                case .lessThanEqualTo:
                                    return comparison.amount <= Double(comparisonValue)!
                                case .equalTo:
                                    return comparison.amount == Double(comparisonValue)!
                                }
                            }
                            
                        }
                        else {
                        
                            if expenseType != .none {
                                newValues = viewModel.expenses.filter {
                                    item in
                                    
                                    item.category == expenseType
                                }
                            }
                            else {
                                newValues = viewModel.expenses
                            }
                            
                            print(newValues.count)
                        }
                        filteredExpenses = newValues
                    }
                    else {
                        filteredExpenses.removeAll()
                    }
                }
            }
        }
    }
    
    func deleteExpense(_ expense: Expense) {
        withAnimation {
            if filterCount > 0 {
                
                if viewModel.deleteExpense(expense: expense) {
                    if let index = filteredExpenses.firstIndex(where: { $0.id == expense.id }) {
                        filteredExpenses.remove(at: index)
                    }
                    if let index = viewModel.expenses.firstIndex(where: { $0.id == expense.id }) {
                        viewModel.expenses.remove(at: index)
                    }
                    
                    if viewModel.expenses.isEmpty {
                        filterByCategory = false
                        filterByExpense = false
                        comparisonType = .equalTo
                        comparisonValue = ""
                    }
                }
                
            }
            else {
                if viewModel.deleteExpense(expense: expense) {
                    if let index = viewModel.expenses.firstIndex(where: { $0.id == expense.id }) {
                        viewModel.expenses.remove(at: index)
                    }
                    if viewModel.expenses.isEmpty {
                        filterByCategory = false
                        filterByExpense = false
                        comparisonType = .equalTo
                        comparisonValue = ""
                    }
                }
            }
        }
    }
}

struct ExpenseRow : View {
    var expense: Expense
    var body: some View {
        VStack(alignment: .leading) {
            if let date = expense.date {
                HStack {
                    Text(expense.amount, format: .currency(code: "INR"))
                        .font(.title2)
                    Spacer()
                    Text(formattedDate(date: date))
                        .font(.body)
                    
                }
            }
            else {
                Text(expense.amount, format: .currency(code: "INR"))
                    .font(.title2)
            }
            
            HStack {
                Image(expense.category.rawValue, bundle: nil)
                    .renderingMode(.template)
                Text("\(expense.category.itemName)")
                    .lineLimit(2)
                    .font(.title2)
                    .foregroundStyle(Color(uiColor: .lightGray))
                
            }
            .padding(.bottom, 8)
            if let description = expense.description {
                Text(description)
                    .font(.body)
                    .foregroundStyle(Color(uiColor: .systemGray2))
            }
        }
    }
}

//struct ExpenseListView_PV : PreviewProvider {
//    static var previews: some View {
//        ExpenseListView()
//    }
//}


struct CustomLabel: View {
  let badgeCount: Int? // Optional badge count

  var body: some View {
    ZStack {
      Image("filter") // Adjust for system or custom image
            .renderingMode(.template)
      
      if let count = badgeCount {
        Text(String(count))
          .font(.system(size: 10))
          .foregroundColor(.white)
          .frame(minWidth: 15, minHeight: 15)
          .background(Color.red)
          .clipShape(Circle())
          .offset(x: 15, y: -5) // Adjust badge position as needed
      }
    }
  }
}
