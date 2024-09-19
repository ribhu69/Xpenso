//
//  ExpenseListView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import SwiftUI
import Lottie

struct ExpenseListView : View {
    @Environment(\.colorScheme) var colorScheme
    @State var filterByCategory = false
    @State var isCategorySelectorVisible = false
    @State var expenseType : ExpenseCategory = .none
    
    @State var filterByExpense = false
    @State var isExpenseComparatorVisible = false

    @State var addExpense : Bool = false
    @State var addFilter : Bool = false
    @State var showGraph : Bool = false
    @State var filterCount : Int = 0
    
    
    @State var showDeleteExpenseAlert = false
    @State private var expenseToDelete : Expense?
    @ObservedObject var viewModel : ExpenseListViewModel
    
    @State var filteredExpenses : [Expense] = []
    
    init(viewModel : ExpenseListViewModel) {
        self.viewModel = viewModel
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Manrope-Regular", size: UIFont.labelFontSize)!,
        ]
        appearance.largeTitleTextAttributes = [
                    .font: UIFont(name: "Manrope-Regular", size: 34)!
                ]
        appearance.backgroundColor = UIColor.systemBackground
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        viewModel.getExpenses()
    }
    var body: some View {
        NavigationView {
            VStack {
                
                    if viewModel.expenses.isEmpty {
                        LottieView(animation: .named("wallet"))
                            .playing()
                            .looping()
                            .frame(width: 80, height: 80)
                        
                        

                        Text("No Expenses Found")
                            .setCustomFont(size: UIFont.preferredFont(forTextStyle: .body).pointSize)
                            .padding(.horizontal, 8)
                        
                        Button(action: {
                            addExpense = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Add Expense")
                                    .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title3).pointSize)

                                    .padding(.horizontal, 8)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 1.5)
                                    .foregroundStyle(Color.clear)
                                
                            }
                            
                        }
                        .sheet(isPresented: $addExpense, content: {
                            NavigationView {
                                
                                AddExpenseView() { newExpense in
                                    addExpense.toggle()
                                    viewModel.addExpense(expense: newExpense)
                                }
                                .navigationTitle("Add Expense")
                            }
                        })
                    }
                    else {
                        List {
                            ForEach(viewModel.expenses, id: \.id) { expense in
                                
                                NavigationLink(destination: ExpenseDetailView(expense: expense)) {
                                    ExpenseRow(expense: expense)
                                    
                                }

                                    .swipeActions {
                                        Button(role: .destructive) {
                                            expenseToDelete = expense
                                            showDeleteExpenseAlert.toggle()
                                        } label: {
                                            Image("delete", bundle: nil)
                                                .renderingMode(.template)
                                            
                                        }
                                        .tint(Color.red)
                                    }
                                  
                            } .listRowSeparator(.hidden)
                        }.listStyle(.plain)
                        
                    }
            }
            .onReceive(NotificationCenter.default
                .publisher(for: NSNotification.Name("allFilesCleared")), perform: { _ in
                    viewModel.removeAllExpenses()
            })
            .toolbar {
                if !viewModel.expenses.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {

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
            .alert("Delete Expense", isPresented: $showDeleteExpenseAlert, presenting: expenseToDelete) { item in
                Button("No", role: .cancel) {
                    expenseToDelete = nil
                }
                Button("Yes", role: .destructive) {
                    guard let expenseToDelete else {return}
                        deleteExpense(expenseToDelete)
                    
                }
            } message: { item in
                Text("Deleting this expense will also remove its comments and attachments. Continue?")
            }
            
            .sheet(isPresented: $addExpense, content: {
                NavigationView {
                    AddExpenseView() { newExpense in
                        addExpense.toggle()
                        viewModel.expenses.append(newExpense)
                    }
                    .navigationTitle("Add Expense")
                }
            })
            .navigationTitle("Xpenso")
        }
       
    }
    
    func deleteExpense(_ expense: Expense) {
        _ = viewModel.deleteExpense(expense: expense)
    }
}

struct ExpenseRow : View {
    @Environment(\.colorScheme) var colorScheme

    var expense: Expense
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                
                Text(expense.amount, format: .currency(code: "INR"))
                    .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
                Text(expense.desc ?? "No Description")
                    .setCustomFont(size: UIFont.preferredFont(forTextStyle: .body).pointSize)
                    .foregroundStyle(expense.desc != nil ? Color(uiColor: .lightGray) : .secondary)
                if let date = expense.date {
            
                    HStack {
                      
                        Image(expense.category.rawValue, bundle: nil)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundStyle(expense.category.color(for: colorScheme))
                        
                        Image("dot", bundle:nil)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 10, height: 10)
                            .rotationEffect(.degrees(90))
                            .foregroundStyle(Color.secondary)
                        
                        
                        Image("calender", bundle: nil)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundStyle(Color.secondary)
                        
                        Text(formattedDate(date: date))
                            .setCustomFont(size: UIFont.preferredFont(forTextStyle: .body).pointSize)
                            .foregroundStyle(Color.secondary)
                      

                    }
               }
            }
                Spacer()
        }
    }
}
#Preview(body: {
    ExpenseListView(
        viewModel: ExpenseListViewModel(
            expenseListService: ExpenseListServiceImpl()
        ))
    
})
