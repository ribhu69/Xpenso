//
//  AddABudgetView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 15/06/24.
//

import SwiftUI

struct AddABudgetView: View {
    @State private var selectedMonth = Calendar.current.component(.month, from: Date()) - 1
    @State private var budgetTitle = ""
    @State private var budgetType : BudgetType = .monthly
    @State private var allocatedBudget: String = ""
    var budgetStyle : BudgetStyle
    var onSave : (Budget) -> Void
    var editingMode = false
    var budgetInEdit : Budget?

    private let months = Calendar.current.monthSymbols
    

    init(budgetStyle: BudgetStyle, onSave: @escaping (Budget) -> Void, editingMode: Bool = false, budgetInEdit: Budget? = nil) {
           self.budgetStyle = budgetStyle
           self.onSave = onSave
           self.editingMode = editingMode
           self.budgetInEdit = budgetInEdit
           
           // Initialize states if editing existing budget
           if let budget = budgetInEdit {
               _budgetTitle = State(initialValue: budget.budgetTitle)
               _allocatedBudget = State(initialValue: String(budget.amount))
               _budgetType = State(initialValue: budget.budgetType)
               if budgetStyle == .periodic {
                   _selectedMonth = State(initialValue: Calendar.current.component(.month, from: budget.startDate!))
               }
              
               // Add logic for selectedMonth if necessary for periodic budgets
           }
       }
    
    var body: some View {
        
        
        
       
        
        switch budgetStyle {
        case .periodic:
            NavigationView(content: {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Budget Title")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                TextField("Enter Title", text: $budgetTitle)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(UIColor.secondarySystemBackground))
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }
                            
                            
                            HStack(content: {
                                Text("Select Month")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                Picker("Month", selection: $selectedMonth) {
                                    ForEach(0..<months.count, id: \.self) { index in
                                        Text(self.months[index]).tag(index)
                                    }
                                }
                                .pickerStyle(DefaultPickerStyle())
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(UIColor.secondarySystemBackground))
                                        .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                        
                                )
                                .padding(.horizontal)
                            })
                            
                            HStack(content:  {
                                Text("Select Type")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                Picker("Weekly", selection: $budgetType) {
                                    ForEach(BudgetType.allCases) { item in
                                        Text(item.displayValue).tag(item)
                                    }
                                }
                                .pickerStyle(DefaultPickerStyle())
                                .disabled(editingMode)
                                
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(UIColor.secondarySystemBackground))
                                        .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                )
                            })
                          
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Allocated Budget")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                TextField("Enter budget", text: $allocatedBudget)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(UIColor.secondarySystemBackground))
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                                    .keyboardType(.decimalPad)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                    
                    .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
                }
                .navigationTitle("Add \(budgetType.displayValue) Budget")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            
                            let budget = Budget(amount: Double(allocatedBudget)!, budgetTitle: budgetTitle, budgetType: budgetType, budgetStyle: .periodic, startDate: Date())
                            
                            onSave(budget)
                        }
                        .disabled(allocatedBudget.isEmpty)
                    }
                }
            })
        case .adhoc:
            NavigationView(content: {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Budget Title")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                TextField("Enter Title", text: $budgetTitle)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(UIColor.secondarySystemBackground))
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }
                            
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Allocated Budget")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                TextField("Enter budget", text: $allocatedBudget)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(UIColor.secondarySystemBackground))
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                                    .keyboardType(.decimalPad)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                    
                    .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
                }
                .navigationTitle("Add Adhoc Budget")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            
                            let budget = Budget(amount: Double(allocatedBudget)!, budgetTitle: budgetTitle, budgetType: .none, budgetStyle: .adhoc, startDate: nil)
                            
                            onSave(budget)
                        }
                        .disabled(allocatedBudget.isEmpty && budgetTitle.isEmpty)
                    }
                }
            })
        }
       
    }
}

#Preview {
    AddABudgetView(budgetStyle: .adhoc
    ) { item in
        //
    }
}
