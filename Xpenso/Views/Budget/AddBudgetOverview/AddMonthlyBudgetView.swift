//
//  AddMonthlyBudgetView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 15/06/24.
//

import SwiftUI

struct AddMonthlyBudgetView: View {
    @State private var selectedMonth = Calendar.current.component(.month, from: Date()) - 1
    @State private var budgetTitle = ""
    @State private var budgetType : BudgetType = .monthly
    @State private var allocatedBudget: String = ""
    
    var onSave : (Budget) -> Void

    private let months = Calendar.current.monthSymbols

    var body: some View {
        
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
                                        .shadow(radius: 5)
                                )
                                .padding(.horizontal)
                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
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
                                    .shadow(radius: 5)
                            )
                            .padding(.horizontal)
                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Select Month")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Picker("Month", selection: $budgetType) {
                                ForEach(BudgetType.allCases) { item in
                                    Text(item.displayValue).tag(item)
                                }
                            }
                            .pickerStyle(DefaultPickerStyle())
                            
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .shadow(radius: 5)
                            )
                            .padding(.horizontal)
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
                                        .shadow(radius: 5)
                                )
                                .keyboardType(.decimalPad)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
                
                .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            }
            .navigationTitle("Add Monthly Budget")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let budget = Budget(title: budgetTitle, amount: Double(allocatedBudget)!, budgetType: budgetType)
                        onSave(budget)
                    }
                    .disabled(allocatedBudget.isEmpty)
                }
            }
        })
        
        
       
    }
}

#Preview {
    AddMonthlyBudgetView(onSave: { budget in
        
    })
}
