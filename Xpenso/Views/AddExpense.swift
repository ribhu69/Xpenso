//
//  AddExpense.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import SwiftUI

struct AddExpenseView : View{
    
    @Binding var isAddExpense : Bool
    @State var amount : String = ""
    @State var description : String = ""
    @State var presentingModal = false
    @State var presentingDatePicker = false
    @State private var selectedDate = Date()
    
    @State var expenseType : ExpenseCategory = .none
    var onSave: (Expense) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image("money", bundle: nil)
                        .renderingMode(.template)
                    TextField(text: $amount, prompt: Text("Amount")) {}
                        .padding()
                        .keyboardType(.decimalPad)
                }
                  
                HStack {
                    Image("notes", bundle: nil)
                        .renderingMode(.template)
                    TextField(text: $description, prompt: Text("Description")) {}
                        .padding()
                }
                
                    
                HStack {
                    Image("category", bundle: nil)
                        .renderingMode(.template)
                        .padding(.top)
                    HStack {
                        Image(expenseType.rawValue, bundle: nil)
                            .renderingMode(.template)
                        Text(expenseType.itemName)
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
                    TextField(getFormattedDate(), text: .constant(""))
                                   .onTapGesture {
                                       self.presentingDatePicker.toggle()
                                   }
                                   .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.vertical)
                if presentingDatePicker {
                    ZStack {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .transition(.move(edge: .bottom))
                            .onChange(of: selectedDate, { _, _ in
                                presentingDatePicker.toggle()
                            })
                        
                    }
                }
                    Spacer()
                    
                        .navigationBarItems(trailing: Button("Save") {
                            let newExpense = Expense(amount: Double(amount) ?? 0, category: expenseType, description: description.isEmpty ? nil : description, date: selectedDate) // Assuming description is not implemented in the UI
                                        onSave(newExpense) // Call the closure to save the expense
                                        isAddExpense = false // Dismiss the AddExpenseView
                                    })
                    
                }
                .padding(.horizontal, 8)
                .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
    }
    
    private func getFormattedDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: selectedDate)
        }
}

struct AddExpense_PV : PreviewProvider {
    static var previews: some View
    {
        AddExpenseView(isAddExpense: .constant(true)) {_ in 
            
        }
    }
}
