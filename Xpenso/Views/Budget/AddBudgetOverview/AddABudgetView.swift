//
//  AddABudgetView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 15/06/24.
//

import SwiftUI

struct AddABudgetView: View {
    
    @State private var navBarTitle = ""
    @State private var selectedMonth = Calendar.current.component(.month, from: Date()) - 1
    @State private var budgetTitle = ""
    @State private var budgetDescription = ""
    @State private var budgetType : BudgetType = .monthly
    @State private var allocatedBudget: String = ""
    @State private var startDate = Date()

    var budgetStyle : BudgetStyle
    var onSave : (Budget) -> Void
    var editingMode = false
    var budgetInEdit : Budget?
    
    private let months = Calendar.current.monthSymbols
    
    
    init(budgetStyle: BudgetStyle, editingMode: Bool = false, budgetInEdit: Budget? = nil, onSave: @escaping (Budget) -> Void) {
        self.budgetStyle = budgetStyle
        self.onSave = onSave
        self.editingMode = editingMode
        self.budgetInEdit = budgetInEdit
        
        // Initialize states if editing existing budget
        if let budget = budgetInEdit {
            _budgetTitle = State(initialValue: budget.budgetTitle)
            _budgetDescription = State(initialValue: budget.budgetDescription ?? "")
            _allocatedBudget = State(initialValue: String(budget.amount))
            _budgetType = State(initialValue: budget.budgetType)
            _selectedMonth = State(
                initialValue: Calendar.current.component(.month, from: budget.startDate)
            )
            _budgetType = State(initialValue: budget.budgetType)
            _selectedMonth = State(
                initialValue: Calendar.current.component(.month, from: budget.startDate))
            _startDate = State(initialValue: budget.startDate)
        }
    }
    
    var body: some View {
        
        switch budgetStyle {
        case .periodic:
            
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
                            Text("Budget Description")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            TextField("Enter Description (Optional)", text: $budgetDescription)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(UIColor.secondarySystemBackground))
                                        .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 15, content: {
                            Text("Start Date")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                
                                Text(getFormattedDate(date: startDate))
                                    .setCustomFont()
                                    .disabled(true)
                                    .padding()
                                
                                    .overlay {
                                        
                                        
                                        DatePicker(
                                            "",
                                            selection: $startDate,
                                            displayedComponents: [.date]
                                        )
                                         .blendMode(.destinationOver)
                                        
                                    }
                                    .background(RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(uiColor: .secondarySystemFill), lineWidth: 2))
                            }
                        })
                        
                        VStack(alignment: .leading, spacing: 15, content:  {
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
            
            .navigationTitle(budgetInEdit != nil ? "Edit Budget" : "Add Periodic Budget")
            .navigationBarTitleDisplayMode(budgetInEdit != nil ? .inline : .automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if editingMode {
                            guard let budgetInEdit else {
                                fatalError("Budget in Edit cannot be nil")
                            }
                            budgetInEdit.amount = Double(allocatedBudget)!
                            budgetInEdit.budgetTitle = budgetTitle
                            budgetInEdit.startDate = startDate
                            budgetInEdit.budgetDescription = budgetDescription
                            onSave(budgetInEdit)
                        }
                        else {
                            let budget = Budget(
                                id: UUID().uuidString,
                                amount: Double(allocatedBudget)!,
                                budgetTitle: budgetTitle,
                                budgetDescription: budgetDescription,
                                budgetType: budgetType,
                                budgetStyle: .periodic,
                                startDate: startDate
                            )
                            
                            onSave(budget)
                        }
                    }
                    .disabled(allocatedBudget.isEmpty)
                }
            }
            
        case .adhoc:
            
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
                            Text("Budget Description")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            TextField("Enter Description (Optional)", text: $budgetDescription)
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
            .navigationTitle(budgetInEdit != nil ? "Edit Adhoc Budget" : "Add Adhoc Budget")
            .navigationBarTitleDisplayMode(budgetInEdit != nil ? .inline : .automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                        let budget = Budget(
                            id: UUID().uuidString,
                            amount: Double(allocatedBudget)!,
                            budgetTitle: budgetTitle,
                            budgetType: budgetType,
                            budgetStyle: .adhoc,
                            startDate: startDate
                        )
                        
                        onSave(budget)
                    }
                    .disabled(allocatedBudget.isEmpty && budgetTitle.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddABudgetView(budgetStyle: .periodic
    ) { item in
        //
    }
}
