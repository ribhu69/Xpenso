//
//  BudgetDetailView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 20/06/24.
//

import SwiftUI
import SwiftData
import Lottie

struct BudgetDetailView : View {
    var budget: Budget
    @State var mappedExpenses = [Expense]()
    var dateformatter = DateFormatter()
    var viewModel : BudgetDetailViewModel
    
    @State private var chairRotation: Angle = .degrees(0)
    @State var toggleValue = false
    @State private var timer: Timer?
    @State var showAddExpense : Bool = false
    
    var body: some View {
        VStack {
            
            if viewModel.relatedExpenses.isEmpty {
                
                VStack {
                    HStack {
                        
                        
                        VStack(alignment: .leading) {
                            Text(budget.budgetTitle)
                                .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title2).pointSize)
                                .padding(.bottom, 8)
                            Text("\(budget.amount, specifier: "%.2f")")
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
                            
                        }
                        .padding(.leading, 8)
                        Spacer()
                    }
                    Spacer()
                    
//                    Image("emptyChair", bundle: nil)
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundStyle(Color.secondary)
//                        .rotationEffect(chairRotation, anchor: .bottom)
//                    
//                        .frame(width: 50, height: 50)
//                    
//                        .onAppear(perform: {
//                            startTimer()
//                        })
                    
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
                    
                    Spacer()
                }
            }
            else {
                List {
                    Section {
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(budget.budgetTitle)
                                    .font(.title2)
                                    .padding(.bottom, 8)
                                Text("\(budget.amount, specifier: "%.2f")")
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
                                    
                                    Text("-")
                                        .foregroundStyle(.secondary)
                                    
                                    if budget.budgetStyle == .periodic, let endDate = budget.endDate {
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
                                
                                
                            }
                            .padding(.leading, 8)
                            Spacer()
                        }
                    }
                    .listSectionSeparator(.hidden)
                    
                    
                    ForEach(viewModel.relatedExpenses) { expense in
                        ExpenseRow(expense: expense)
                            .swipeActions {
                                Button(role: .destructive) {
                                    
                                    Task {
                                        if await viewModel.deleteExpense(expense: expense),
                                            let index = mappedExpenses.firstIndex(where: { element in
                                                element.id == expense.id
                                            }) {
                                            mappedExpenses.remove(at: index)
                                        }
                                    }
                                    
                                }
                            label: {
                                Image("delete", bundle: nil)
                                    .renderingMode(.template) // Apply rendering mode
                            }
                            }
                    } .listRowSeparator(.hidden)
                    
                    
                }.listStyle(.plain)
            }
            
            
            
            
        }
        .padding(.horizontal, 8)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 1)) {
                toggleValue.toggle()
                chairRotation = toggleValue ? Angle(degrees: 10) : Angle(degrees: -10)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true) // Store the container in memory since we don't actually want to save the preview data
    let container = try! ModelContainer(for: Budget.self, configurations: config)

    return BudgetDetailView(budget: Budget.singularBudgetSample(), viewModel: BudgetDetailViewModel(budget: Budget.singularBudgetSample(), context: DatabaseHelper.shared.getModelContext()))
}
