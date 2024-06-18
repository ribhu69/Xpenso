import SwiftUI

struct BudgetView : View {
    @State var showAddBudgetView = false
    var viewModel : BudgetViewModel
    @State var monthlyBudgets = [Budget]()
    @State var adhocBudgets = [Budget]()
    @State private var addBudget = false
    var body : some View {
        
        NavigationView(content: {
            if monthlyBudgets.isEmpty && adhocBudgets.isEmpty {
                VStack {
                    ScrollView {
                        
                        VStack(alignment: .leading) {
                            
                            HStack {
                                Text("Getting Started")
                                .font(.title)
                                .padding(.bottom, 16)
                              
                                   
                            }
                            .padding(.horizontal, 8)
                            
                            CardView(title: "Monthly Budget", image: Image("calender", bundle: nil), subtitle:  "Track your monthly expenses. See spending across various categories.")
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(Color.clear)
                                }
                                .onTapGesture {
                                    showAddBudgetView.toggle()
                                }
                                .sheet(isPresented: $showAddBudgetView, content: {
                                    AddMonthlyBudgetView { budget in
                                        // add further code.
                                        
                                        viewModel.addBudget(budget: budget)
                                        monthlyBudgets.append(budget)
                                        showAddBudgetView.toggle()
                                    }
                                })
                            
                            CardView(title: "Adhoc Budget", image: Image("scooter", bundle: nil), subtitle: "Plan a budget for specific events or trips. Manage your expenses for special occasions.")
                                .onTapGesture {
                                    print("Selected 3")
                                }
                            
                        }
                    }
                }
                .padding(.top, 1)
            }
            else {
                VStack {
                    List {
                        Section(header: HStack {
                            Image("calender", bundle: nil)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 4)
                            VStack(alignment: .leading) {
                                Text("Monthly Budget")
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
                            ForEach(monthlyBudgets) { budget in
                                HStack {
                                    
                                    VStack(alignment: .leading) {
                                        /*@START_MENU_TOKEN@*/Text(budget.budgetTitle)/*@END_MENU_TOKEN@*/
                                            .font(.title2)
                                            .padding(.bottom, 8)
                                        Text("\(budget.amount, specifier: "%.2f")")
                                            .font(.title3)
                                    }
                                    .padding(.vertical, 8)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                            }
                        }
                        
                        
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
                            ForEach(adhocBudgets) { budget in
                                HStack {
                                    
                                    VStack(alignment: .leading) {
                                        /*@START_MENU_TOKEN@*/Text(budget.budgetTitle)/*@END_MENU_TOKEN@*/
                                            .font(.title2)
                                            .padding(.bottom, 8)
                                        Text("\(budget.amount, specifier: "%.2f")")
                                            .font(.title3)
                                    }
                                    .padding(.vertical, 8)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                            }
                        }
                        
                        
                    }
                    .listStyle(PlainListStyle())
                }
                .padding(.top, 1)
                .navigationTitle("Budget View")
                .toolbar {
                    
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                
                                Button(action: {
                                    addBudget = true
                                }) {
                                    
                                    Image("charts")
                                        .renderingMode(.template)
                                    
                                }

                        }
                    }
                }
            }
            
           
        })
    }
}



struct CardView:  View {
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
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 8)
        
    }
}

#Preview {
    BudgetView(viewModel: BudgetViewModel(budgetService: BudgetServiceImpl()))
    //    CardView(title: "Test", subtitle: "Test")
}
