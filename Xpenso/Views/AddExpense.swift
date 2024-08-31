//
//  AddExpense.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import SwiftUI
import SwiftData

struct AddExpenseView : View{
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State var amount : String = ""
    @State var description : String = ""
    @State var presentingModal = false
    @State var presentingBudgetChooser = false
    @State private var selectedDate = Date()
    @State var isPartOfBudget : Bool = false
    @State var selectedBudget : Budget?


    
    @State var expenseType : ExpenseCategory = .none

    var onSave: (Expense) -> Void
    var expenseService : ExpenseService = ExpenseServiceImpl()
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                HStack {
                    Image("money", bundle: nil)
                        .renderingMode(.template)
                        .foregroundStyle(AppTheme.shared.selectedColor)
                    TextField(text: $amount, prompt: Text("Amount")) {}
                        .padding()
                        .keyboardType(.decimalPad)
                        .setCustomFont()
                }
                
                HStack {
                    Image("notes", bundle: nil)
                        .renderingMode(.template)
                        .foregroundStyle(AppTheme.shared.selectedColor)
                    TextField(text: $description, prompt: Text("Description")) {}
                        .padding()
                        .setCustomFont()
                }
                
                
                HStack {
                    Image("category", bundle: nil)
                        .renderingMode(.template)
                        .foregroundStyle(AppTheme.shared.selectedColor)
                        .padding(.top)
                    HStack {
                        Image(expenseType.rawValue, bundle: nil)
                            .renderingMode(.template)
                            .foregroundStyle(expenseType.color(for: colorScheme))
                        Text(expenseType.itemName)
                            .setCustomFont()
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 2)
                    )
                    .onTapGesture {
                        self.presentingModal = true
                    }
                    .sheet(isPresented: $presentingModal, content: {
                        NavigationView {
                            ExpenseCategoryView(expenseType: $expenseType, isPresented: $presentingModal)
                                .navigationTitle("Select Expense Type")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    })
                    .padding(.top, 16)
                }
                
                HStack {
                    Image("date", bundle: nil)
                        .renderingMode(.template)
                        .foregroundStyle(AppTheme.shared.selectedColor)
                    Text(getFormattedDate(date: selectedDate))
                        .setCustomFont()
                        .disabled(true)
                        .padding()
                    
                        .overlay {
                            
                            DatePicker(
                                "",
                                selection: $selectedDate,
                                displayedComponents: [.date]
                            )
                             .blendMode(.destinationOver)
                            
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 2)
                        }

                }
                .padding(.vertical)
                
                
                if isPartOfBudget {
                    HStack {
                        Image("budget", bundle: nil)
                            .renderingMode(.template)
                            .foregroundStyle(AppTheme.shared.selectedColor)
                            .padding(.top)
                        HStack {
                            Text(selectedBudget!.budgetTitle)
                                .setCustomFont()
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 2)
                        )
                    }
                }
              
                Spacer()
                
                    .navigationBarItems(trailing: Button("Save") {
                        
                        let newExpense = Expense(id: UUID().uuidString, amount: Double(amount) ?? 0, category: expenseType, description: description.isEmpty ? nil : description, date: selectedDate) // Assuming description is not implemented in the UI
                        newExpense.associatedBudget = selectedBudget // by default this will be nil only.
                        
                        if isPartOfBudget {
                            onSave(newExpense)
                            dismiss()
                        }
                        else {
                            Task {
                                if await expenseService.addExpense(expense:newExpense) {
                                    onSave(newExpense)
                                    dismiss()
                                }
                              
                            }
                        }
                    }
                        .disabled(amount.isEmpty)
                    )
                
            }
            .padding(.horizontal, 8)
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
    }
    
    
}

struct AddExpense_PV : PreviewProvider {
    static var previews: some View
    {

            let config = ModelConfiguration(isStoredInMemoryOnly: true) // Store the container in memory since we don't actually want to save the preview data
            let container = try! ModelContainer(for: Expense.self, configurations: config)
        
            return AddExpenseView( presentingModal: false) { _ in
                //
            }
        
        
    }
}
