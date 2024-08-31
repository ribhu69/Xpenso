//
//  BudgetV2View.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 25/08/24.
//

import SwiftUI
import Lottie

struct BudgetView: View {
    
    @State var showCommonAddBudgetView = false
    @State var showAddBudgetView = false
    @State var showAddBudgetViewType: BudgetStyle?
    @ObservedObject var viewModel: BudgetViewModel
    @State var editPeriodicBudget =  false
    @State var editAdhocBudget =  false
    
    init(viewModel: BudgetViewModel) {
        self.viewModel = viewModel
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Manrope-Regular", size: UIFont.labelFontSize)!
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Manrope-Regular", size: 34)!
        ]
        appearance.backgroundColor = UIColor.systemBackground
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                if viewModel.budgets.isEmpty {
                    Spacer()
                    LottieView(animation: .named("hamster"))
                        .playing()
                        .looping()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        
                    
                    
                    Text("No budget? Add one to keep rolling!")
                        .setCustomFont()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                    
                    
                    Button(action: {
                        showCommonAddBudgetView.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Budget")
                                .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title3).pointSize)

                        }
                    })
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 1.5)
                            .foregroundStyle(Color.clear)
                    }
                    Spacer()
                        .sheet(isPresented: $showCommonAddBudgetView, content: {
                            NavigationView {
                                AddBudgetView(viewModel: viewModel)
                            }
                        })
                    
                } else {
                    List {
                        ForEach(viewModel.budgets) { budget in
                            let viewModel = BudgetDetailViewModel(
                                budget: budget,
                                context: DatabaseHelper.shared.getModelContext()
                            )
                            NavigationLink(destination: BudgetDetailView(budget: budget, viewModel: viewModel)) {
                                VStack(alignment: .leading) {
                                    HStack(alignment: .center) {
                                        
                                        Text(budget.budgetTitle)
                                            .setCustomFont()
                                        Image(systemName: budget.budgetStyle == .periodic ? "p.square" : "a.square")
                                            .resizable()
                                            .frame(width: 12, height: 12)
                                            .foregroundStyle(budget.budgetStyle == .periodic ? Color.blue : Color.green)

                                    }
                                    .padding(.bottom , 4)
                                    Text("\(budget.amount, specifier: "%.2f")")
                                        .setCustomFont(weight: FontWeight.medium, size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                                }
                                .padding(.vertical, 4)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    deleteBudget(budget: budget)
                                } label: {
                                    Image("delete", bundle: nil)
                                        .renderingMode(.template) // Apply rendering mode
                                }
                                .tint(Color.red)
                                Button() {
                                    editPeriodicBudget.toggle()
                                } label: {
                                    Image("edit", bundle: nil)
                                        .renderingMode(.template)
                                }
                                .tint(Color.gray)
                            }
                            .sheet(isPresented: $editPeriodicBudget,
                                   content: {
                                
                                NavigationView {
                                    AddABudgetView(
                                        budgetStyle: .periodic,
                                        editingMode: true,
                                        budgetInEdit: budget
                                    ) { budget in
                                        
                                        self.viewModel.updateBudget(budget: budget)
                                        editPeriodicBudget.toggle()
                                    }
                                }
                                
                            })
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                    
                }
            }
            .navigationTitle("Budget")
            
            .toolbar {
            if !(viewModel.budgets.isEmpty) {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            showAddBudgetViewType = .periodic
                            showAddBudgetView.toggle()
                        }) {
                            HStack {
                                Image("calender")
                                    .renderingMode(.template)
                                Text("Periodic Budget")
                            }
                        }
                        Button(action: {
                            showAddBudgetViewType = .adhoc
                            showAddBudgetView.toggle()
                        }) {
                            HStack {
                                Image("scooter")
                                    .renderingMode(.template)
                                Text("Adhoc Budget")
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
            .sheet(isPresented: $showAddBudgetView) {
            if let budgetStyle = showAddBudgetViewType {
                NavigationView {
                    AddABudgetView(budgetStyle: budgetStyle) { budget in
                        viewModel.addBudget(budget: budget)
                        showAddBudgetViewType = nil
                        showAddBudgetView = false
                    }
                }
            }
        }
        }
    }
    
    func deleteBudget(budget: Budget) {
        _ = viewModel.deleteBudget(budget: budget)
    }
}



#Preview {
    BudgetView(viewModel: BudgetViewModel(budgetService: BudgetServiceImpl(), context: DatabaseHelper.shared.getModelContext()))
}
//    func editBudget(budget: Budget) {
//        editBudget.toggle()
//    }

