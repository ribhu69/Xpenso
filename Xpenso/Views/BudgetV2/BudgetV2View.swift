//
//  BudgetV2View.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 25/08/24.
//

import SwiftUI

struct BudgetV2View: View {
    
    @State var showAddBudgetView = false
    @State var showAddBudgetViewType: BudgetStyle?
    @ObservedObject var viewModel: BudgetViewModel
    @State var showAdhocBudgetView = false
    @State var editPeriodicBudget =  false
    @State var editAdhocBudget =  false
    
    init(viewModel: BudgetViewModel) {
        self.viewModel = viewModel
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Quicksand-SemiBold", size: UIFont.labelFontSize)!
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Quicksand-SemiBold", size: 34)!
        ]
        appearance.backgroundColor = UIColor.systemBackground
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.adhocBudget.isEmpty && viewModel.periodicBudgets.isEmpty {
                    Spacer()
                    Image("adhoc", bundle: nil)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.secondary)
                        .frame(width: 50, height: 50)
                    
                    Text("No budget? Add one to keep rolling!")
                        .setCustomFont()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                    
                    
                    Button(action: {
                        // No action needed here because we are using the menu
                    }, label: {
                        Menu {
                            Button(action: {
                                showAddBudgetViewType = .periodic
                                showAddBudgetView.toggle()
                            }) {
                                HStack {
                                    Image("calender")
                                        .renderingMode(.template)
                                    Text("Add Periodic Budget")
                                }
                            }
                            Button(action: {
                                showAddBudgetViewType = .adhoc
                                showAddBudgetView.toggle()
                            }) {
                                HStack {
                                    Image("scooter")
                                        .renderingMode(.template)
                                    Text("Add Adhoc Budget")
                                }
                            }
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Add Budget")
                                    .setCustomFont(fontName: "Quicksand-SemiBold", size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                            }
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
                } else {
                    List {
                        if !viewModel.periodicBudgets.isEmpty {
                            Section(header: HStack {
                                Image("calender", bundle: nil)
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing, 4)
                                VStack(alignment: .leading) {
                                    Text("Periodic Budget")
                                        .font(.headline)
                                        .textCase(.none)
                                        .foregroundColor(.primary)
                                    Text("Your expenses over a period of time.")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .textCase(.none)
                                }
                                .padding(.vertical, 8)
                            }) {
                                ForEach(viewModel.periodicBudgets) { budget in
                                    let viewModel = BudgetDetailViewModel(
                                        budget: budget,
                                        context: DatabaseHelper.shared.getModelContext()
                                    )
                                    NavigationLink(destination: BudgetDetailView(budget: budget, viewModel: viewModel)) {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                HStack {
                                                    Image("moneyBag", bundle:nil)
                                                        .renderingMode(.template)
                                                        .resizable()
                                                        .frame(width: 18, height: 18)
                                                        .foregroundStyle(budget.budgetType == .daily ? Color.yellow : budget.budgetType == .weekly ? Color.blue : Color.green)
                                                    Text(budget.budgetTitle)
                                                        .font(.title2)
                                                        .padding(.bottom, 8)
                                                }
                                                Text("\(budget.amount, specifier: "%.2f")")
                                                    .font(.title3)
                                            }
                                            .padding(.vertical, 8)
                                            Spacer()
                                        }
                                    }
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            deleteBudget(budget: budget)
                                        } label: {
                                            Image("delete", bundle: nil)
                                                .renderingMode(.template) // Apply rendering mode
                                        }
                                        Button() {
                                            editPeriodicBudget.toggle()
                                        } label: {
                                            Image("edit", bundle: nil)
                                                .renderingMode(.template) // Apply rendering mode
                                        }
                                    }
                                    .sheet(isPresented: $editPeriodicBudget, content: {
                                       AddABudgetView(budgetStyle: .periodic, onSave: { budget in
                                           // edited budget has to be updated here.
                                           editPeriodicBudget.toggle()
                                       },editingMode: true, budgetInEdit: budget)
                                   })
                                }
                            }
                        }
                        
                        if !viewModel.adhocBudget.isEmpty {
                            Section(header: HStack {
                                Image("adhoc", bundle: nil)
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing, 4)
                                VStack(alignment: .leading) {
                                    Text("Adhoc Budget")
                                        .font(.headline)
                                        .textCase(.none)
                                        .foregroundColor(.primary)
                                    Text("Your monthly expenses and savings goals")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .textCase(.none)
                                }
                                .padding(.vertical, 8)
                            }) {
                                ForEach(viewModel.adhocBudget) { budget in
                                    let viewModel = BudgetDetailViewModel(
                                        budget: budget,
                                        context: DatabaseHelper.shared.getModelContext()
                                    )
                                    NavigationLink(destination: BudgetDetailView(budget: budget, viewModel: viewModel)) {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                HStack {
                                                    Image("moneyBag", bundle:nil)
                                                        .renderingMode(.template)
                                                        .resizable()
                                                        .frame(width: 18, height: 18)
                                                    Text(budget.budgetTitle)
                                                        .font(.title2)
                                                        .padding(.bottom, 8)
                                                }
                                                Text("\(budget.amount, specifier: "%.2f")")
                                                    .font(.title3)
                                            }
                                            .padding(.vertical, 8)
                                            Spacer()
                                        }
                                    }
                                    
                                    .sheet(isPresented: $editAdhocBudget, content: {

                                        AddABudgetView(budgetStyle: .adhoc, onSave: { budget in
                                            // edited budget has to be updated here.
                                            editAdhocBudget.toggle()
                                        },editingMode: true, budgetInEdit: budget)
                                    })
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            deleteBudget(budget: budget)
                                        } label: {
                                            Image("delete", bundle: nil)
                                                .renderingMode(.template) // Apply rendering mode
                                        }
                                        Button() {
                                            editAdhocBudget.toggle()
                                        } label: {
                                            Image("edit", bundle: nil)
                                                .renderingMode(.template) // Apply rendering mode
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Budget")
            .toolbar {
                if !(viewModel.adhocBudget.isEmpty && viewModel.periodicBudgets.isEmpty) {
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

//    func editBudget(budget: Budget) {
//        editBudget.toggle()
//    }
}
