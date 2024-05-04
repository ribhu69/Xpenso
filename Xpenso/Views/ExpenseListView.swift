//
//  ExpenseListView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import SwiftUI

struct ExpenseListView : View {
    @State var addExpense : Bool = false
    @State var addFilter : Bool = true
    @State var expenses : [Expense] = [
        Expense(amount: 100, category: .miscellaneous, description: "Bike Petrol", date: Date()),
        Expense(amount: 3000, category: .education, description: "DSA Books Purchased."),
        Expense(amount: 100, category: .miscellaneous, description: nil),
        Expense(amount: 37.63, category: .healthcare, description: "Paracetamol"),
        Expense(amount: 200, category: .transportation, description: "Fuel"),
        Expense(amount: 10000, category: .housing, description: "Bike Petrol", date: Date())
        
    ]
    var body: some View {
        NavigationView {
            VStack {
                if expenses.isEmpty {
                    Image("emptyView", bundle: nil)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 50, height: 50)
                    Text("No Entries Found")
                        .font(.title2)
                    
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
                                expenses.append(newExpense)
                            }
                            .navigationTitle("Add Expense")
                        }
                    })
                }
                else {
                    List {
                        ForEach(expenses, id: \.id) { expense in
                            ExpenseRow(expense: expense)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteExpense(expense)
                                    } label: {
                                        Image("delete", bundle: nil)
                                            .renderingMode(.template) // Apply rendering mode
                                    }
                                }
                        }
                        //.onDelete(perform: deleteExpense)
                        .listRowSeparator(.hidden)
                    }  .listStyle(.plain)
                    
                    VStack {
                        Divider()
                          .background(.gray)
//                        Rectangle()
//                            .frame(width: .infinity, height: 1)
//                            .foregroundStyle(Color.gray)
                        HStack {
                            Text("Total:")
                                .font(.title2)
                            Text(expenses.reduce(0) { $0 + $1.amount }, format: .currency(code: "INR"))
                                .font(.title2)
                                .padding(.leading, 8)
                              
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                }
            }
            .toolbar {
                if !expenses.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button(action: {
                                addFilter = true
                            }) {
                                if addFilter {
                                    CustomLabel( badgeCount: 5)
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
            
            .sheet(isPresented: $addExpense, content: {
                NavigationView {
                    AddExpenseView(isAddExpense: $addExpense) { newExpense in
                        expenses.append(newExpense)
                    }
                    .navigationTitle("Add Expense")
                }
            })
        }
    }
    
    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
    
    func deleteExpense(_ expense: Expense) {
        withAnimation {
            if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
                expenses.remove(at: index)
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
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium

        return dateFormatter.string(from: date)
    }
    
}

struct ExpenseListView_PV : PreviewProvider {
    static var previews: some View {
        ExpenseListView()
    }
}


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
