import SwiftUI

struct BudgetView : View {
    @State var showPeriodicBudgetView = false
    @State var showAdhocBudgetView = false
    @ObservedObject var viewModel : BudgetViewModel
    
    @State private var addBudget = false
    var body : some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                if viewModel.periodicBudgets.isEmpty && viewModel.adhocBudget.isEmpty {
                    
                    Text("Getting Started")
                        .font(.title)
                        .padding(.horizontal, 16)
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            CardView(title: "Periodic Budget", image: Image("calender", bundle: nil), subtitle:  "Track your expenses throughout your day, week or month. See spending across various categories.")
                            
                                .onTapGesture {
                                    showPeriodicBudgetView.toggle()
                                }
                                .sheet(isPresented: $showAdhocBudgetView, content: {
                                    AddMonthlyBudgetView(budgetStyle: .adhoc) { budget in
                                        // add further code.
                                        
                                        viewModel.addBudget(budget: budget)
                                        showAdhocBudgetView.toggle()
                                    }
                                })
                            
                            
                            CardView(title: "Adhoc Budget", image: Image("scooter", bundle: nil), subtitle: "Plan a budget for specific events or trips. Manage your expenses for special occasions.")
                                .onTapGesture {
                                    showAdhocBudgetView.toggle()
                                }
                                .sheet(isPresented: $showPeriodicBudgetView, content: {
                                    AddMonthlyBudgetView(budgetStyle: .periodic) { budget in
                                        // add further code.
                                        
                                        viewModel.addBudget(budget: budget)
                                        showPeriodicBudgetView.toggle()
                                    }
                                })
                            
                        }
                    }
                    .navigationTitle("Budget View")
                    .padding(.top, 1)
                }
                else {
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
                            })  {
                                ForEach(viewModel.periodicBudgets) { budget in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Image("moneyBag", bundle:nil)
                                                    .renderingMode(.template)
                                                    .resizable()
                                                    .frame(width:18, height: 18)
                                                
                                                    .foregroundStyle(budget.budgetType == .daily ? Color.yellow : budget.budgetType == .weekly ? Color.blue : Color.green)
                                                /*@START_MENU_TOKEN@*/Text(budget.budgetTitle)/*@END_MENU_TOKEN@*/
                                                    .font(.title2)
                                                    .padding(.bottom, 8)
                                                
                                            }
                                            Text("\(budget.amount, specifier: "%.2f")")
                                                .font(.title3)
                                            
                                        }
                                        .padding(.vertical, 8)
                                        
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            deleteBudget(budget: budget)
                                        } label: {
                                            Image("delete", bundle: nil)
                                                .renderingMode(.template) // Apply rendering mode
                                        }
                                    }
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
                                
                            }
                            )  {
                                ForEach(viewModel.adhocBudget) { budget in
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            HStack {
                                                
                                                Image("moneyBag", bundle:nil)
                                                    .renderingMode(.template)
                                                    .resizable()
                                                    .frame(width:18, height: 18)
                                                
                                                
                                                /*@START_MENU_TOKEN@*/Text(budget.budgetTitle)/*@END_MENU_TOKEN@*/
                                                    .font(.title2)
                                                    .padding(.bottom, 8)
                                                
                                                
                                            }
                                            Text("\(budget.amount, specifier: "%.2f")")
                                                .font(.title3)
                                            
                                        }
                                        .padding(.vertical, 8)
                                        
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            deleteBudget(budget: budget)
                                        } label: {
                                            Image("delete", bundle: nil)
                                                .renderingMode(.template) // Apply rendering mode
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    if(!viewModel.periodicBudgets.isEmpty) {
                        HStack {
                            Image("dot", bundle: nil)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.yellow)
                                .padding(.trailing, 4)
                            Text("Daily")
                                .font(.subheadline)
                                .foregroundStyle(Color.yellow)
                            Spacer()
                            
                            Image("dot", bundle: nil)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.blue)
                                .padding(.trailing, 4)
                            Text("Weekly")
                                .font(.subheadline)
                                .foregroundStyle(Color.blue)
                            Spacer()
                            
                            Image("dot", bundle: nil)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.green)
                                .padding(.trailing, 4)
                            Text("Monthly")
                                .font(.subheadline)
                                .foregroundStyle(Color.green)
                            
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    
                }
            }
            .padding(.top, 1)
            .navigationTitle("Budget View")
            .toolbar {
                if !(viewModel.adhocBudget.isEmpty && viewModel.periodicBudgets.isEmpty) {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: {
                                showPeriodicBudgetView.toggle()
                            }) {
                                HStack {
                                    Image("calender")
                                        .renderingMode(.template)
                                    Text("Periodic Budget")
                                }
                            }
                            
                            Button(action: {
                                showAdhocBudgetView.toggle()
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
            
            .sheet(isPresented: $showAdhocBudgetView, content: {
                AddMonthlyBudgetView(budgetStyle: .adhoc) { budget in
                    // add further code.
                    
                    viewModel.addBudget(budget: budget)
                    showAdhocBudgetView.toggle()
                }
            })
            .sheet(isPresented: $showPeriodicBudgetView, content: {
                AddMonthlyBudgetView(budgetStyle: .periodic) { budget in
                    // add further code.
                    
                    viewModel.addBudget(budget: budget)
                    showPeriodicBudgetView.toggle()
                }
            })
        }
    }
    
    func deleteBudget(budget: Budget) {
        _ = viewModel.deleteBudget(budget: budget)
    }
}

struct CardView : View {
    var title: String
    var image: Image
    var subtitle: String
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                
                HStack {
                    image.resizable().renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        .frame(width: 25, height: 25)
                    Text(title)
                        .font(.title2)
                        .padding(.bottom, 4)
                        .padding(.top, 4)
                }
                Text(subtitle)
                    .font(.title3)
                    .foregroundStyle(Color.secondary)
                    .padding(.bottom, 8)
                
            }
            
            .padding(.horizontal, 8)
            .padding(.top, 16)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 8)
        
    }
}

//#Preview {
//    BudgetView(viewModel: BudgetViewModel(budgetService: BudgetServiceImpl()))
//    //    CardView(title: "Test", subtitle: "Test")
//}
