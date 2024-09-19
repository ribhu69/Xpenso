//
//  BudgetDetailView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 20/06/24.
//

import SwiftUI
import SwiftData
import Lottie

struct BudgetDetailCard : View {
    var budget: Budget
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(budget.budgetTitle)
                    .setCustomFont(
                        size: UIFont.preferredFont(
                            forTextStyle: .title2
                        ).pointSize
                    )
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                Text(budget.amount, format: .currency(code: "INR"))
                    .font(.title3)
                
                
                HStack {
                    Image("calender", bundle: nil)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.secondary)
                    Text("\(formattedDate(date: budget.startDate))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    
                    if budget.budgetStyle == .periodic, let endDate = budget.endDate {
                        Text("-")
                            .foregroundStyle(.secondary)
                        
                        switch budget.budgetType {
                        case .daily:
                            Text("\(formattedDate(date: endDate))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        case .weekly:
                            Text("\(formattedDate(date: endDate))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        case .monthly:
                            Text("\(formattedDate(date: endDate))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        case .none:
                            Text("")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.bottom, 8)
                
            }
            .padding(.leading, 8)
            Spacer()
        }
        .padding(4)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 0.5, lineCap: .round, dash: [5]))
        }
    }
}

struct BudgetDetailView : View {
    var budget: Budget
    @State var mappedExpenses = [Expense]()
    var dateformatter = DateFormatter()
    @StateObject var viewModel : BudgetDetailViewModel
    @State var toggleValue = false
    @State var showAddExpense : Bool = false
    
    var body: some View {
        VStack {
            
            List {
                
                Section {
                    BudgetDetailCard(budget: budget)
                } footer: {
                    if viewModel.relatedExpenses.isEmpty {
                        VStack {
                            LottieView(animation: .named("randomAnimal"))
                                .playing()
                                .looping()
                                .frame(width: 80, height: 80)
                            
                            
                            Text("No expenses yet, your chair is still empty!")
                                .textCase(.none)
                                .multilineTextAlignment(.center)
                                .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                                .foregroundStyle(Color.secondary)
                                .padding(.horizontal, 8)
                                .padding(.bottom, 8)
                            
                            Button(action: {
                                showAddExpense.toggle()
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
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
                
                ForEach(viewModel.relatedExpenses) { expense in
                    
                    NavigationLink(destination: ExpenseDetailView(expense: expense)) {
                        ExpenseRow(expense: expense)
                            .swipeActions {
                                Button(role: .destructive) {
                                    
                                    Task {
                                        await viewModel.deleteExpense(expense: expense)
                                    }
                                }
                            label: {
                                Image("delete", bundle: nil)
                                    .renderingMode(.template) // Apply rendering mode
                            }
                            }
                    }
                    
                } .listRowSeparator(.hidden)
                
                
            }.listStyle(.plain)
        }
        .sheet(isPresented: $showAddExpense, content: {
            NavigationView {
                
                
                AddExpenseView(isPartOfBudget : true, selectedBudget: budget) { expense in
                    Task {
                        _ = await viewModel.addExpense(expense:expense)
                    }
                }
                .navigationTitle("Add Expense")
                .navigationBarTitleDisplayMode(.inline)
            }
        })
        .toolbar {
            
            if !viewModel.relatedExpenses.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button(action: {
                        showAddExpense.toggle()
                    } , label: {
                        Image(systemName: "plus")
                            .renderingMode(.template)
                    })
                }
            }
        }
        .padding(.horizontal, 8)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true) // Store the container in memory since we don't actually want to save the preview data
    let container = try! ModelContainer(for: Budget.self, configurations: config)
    
    return BudgetDetailView(budget: Budget.singularBudgetSample(), viewModel: BudgetDetailViewModel(budget: Budget.singularBudgetSample(), context: DatabaseHelper.shared.getModelContext()))
}
