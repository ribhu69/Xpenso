//
//  FilterView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import SwiftUI

struct FilterView : View {
    
    @Binding var isFilterViewVisible : Bool
    @Binding var filterByCategory : Bool
    @Binding var isCategorySelectorVisible : Bool
    @Binding var expenseType : ExpenseCategory
    
    @Binding var filterByExpense : Bool
    @Binding var isExpenseComparatorVisible : Bool
    @Binding var comparisonType : Comparison
    @Binding var comparisonValue : String
    
    @Binding var filterCount : Int
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                //MARK: By Category
                HStack(alignment: .center) {
                    RadioButton(selection: $filterByCategory)
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            filterByCategory.toggle()
                        }
                    Text("Category")
                        .font(.title3)
                        .padding(.leading, 8)
                    
                    
                    HStack {
                        Image(expenseType.rawValue, bundle: nil)
                            .renderingMode(.template)
                        Text(expenseType.itemName)
                    }
                    
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 2)
                    )
                    .onTapGesture {
                        self.isCategorySelectorVisible = true
                    }
                    .opacity(!filterByCategory ? 0.5 : 1)
                    .sheet(isPresented: $isCategorySelectorVisible, content: {
                        NavigationView {
                            ExpenseCategoryView(expenseType: $expenseType, isPresented: $isCategorySelectorVisible)
                                .navigationTitle("Select Expense Type")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    })
                    .disabled(!filterByCategory)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    
                }
                
                //MARK: By Expense
                HStack(alignment: .center) {
                    RadioButton(selection: $filterByExpense)
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            filterByExpense.toggle()
                        }
                    Text("Expense")
                        .font(.title3)
                        .padding(.leading, 8)
                    
                    HStack {
                        Image(comparisonType.rawValue, bundle: nil)
                            .renderingMode(.template)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 2)
                            )
                            .onTapGesture {
                                self.isExpenseComparatorVisible = true
                            }
                            .disabled(!filterByExpense)
                            .opacity(!filterByExpense ? 0.5 : 1)
                            .sheet(isPresented: $isExpenseComparatorVisible, content: {
                                NavigationView {
                                    ComparisonView(comparisonType: $comparisonType, isPresented: $isExpenseComparatorVisible)
                                        .navigationTitle("Select Expense Type")
                                        .navigationBarTitleDisplayMode(.inline)
                                }
                            })
                        
                            .padding(.leading, 8)
                            .padding(.trailing, 8)
                        TextField(text: $comparisonValue, prompt: Text("Value")) {}
                            .padding()
                            .keyboardType(.decimalPad)
                            .opacity(!filterByExpense ? 0.5 : 1)
                            .disabled(!filterByExpense)
                    }
                    
                }
            }
            .padding()
            .toolbar {
                if (filterByExpense || filterByCategory) {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Button(action: {
                                comparisonType = .equalTo
                                comparisonValue = ""
                                expenseType = .none
                                filterByExpense = false
                                filterByCategory = false
                                filterCount = 0
                                isCategorySelectorVisible = false
                                expenseType = .none
                                isExpenseComparatorVisible = false
                                comparisonType = .equalTo
                                comparisonValue = ""
                                
                                
                            }) {
                                Image("filterReset")
                                    .renderingMode(.template)
                            }
                        }
                    }
    
                    }
                ToolbarItem(placement: .navigationBarTrailing) {

                        Button(action: {
                            
                            if filterByCategory && filterByExpense {
                                if !comparisonValue.isEmpty {
                                    isFilterViewVisible = false
                                    filterCount = (filterByExpense && filterByCategory) ? 2 : (!filterByExpense && !filterByCategory) ? 0 : 1

                                }
                            }
                            else if !filterByCategory && !filterByExpense {
                                isFilterViewVisible = false
                                filterCount = (filterByExpense && filterByCategory) ? 2 : (!filterByExpense && !filterByCategory) ? 0 : 1

                            }
                            else if filterByExpense, !comparisonValue.isEmpty {
                                isFilterViewVisible = false
                                filterCount = (filterByExpense && filterByCategory) ? 2 : (!filterByExpense && !filterByCategory) ? 0 : 1

                            }
                            else {
                                if filterByCategory  {
                                    isFilterViewVisible = false
                                    filterCount = (filterByExpense && filterByCategory) ? 2 : (!filterByExpense && !filterByCategory) ? 0 : 1

                                }
                            }

                        }) {
                            Text("Save")
                        }
                    }
                }
            }
            .onChange(of: filterByExpense) { oldValue, newValue in
                if newValue == false {
                    comparisonType = .equalTo
                    comparisonValue = ""
                }
                filterCount = (filterByExpense && filterByCategory) ? 2 : (!filterByExpense && !filterByCategory) ? 0 : 1
            }
            .onChange(of: filterByCategory) { oldValue, newValue in
                if newValue == false {
                    expenseType = .none
                }
                filterCount = (filterByExpense && filterByCategory) ? 2 : (!filterByExpense && !filterByCategory) ? 0 : 1
            }
        }
    }


//struct FilterView_PV : PreviewProvider {
//    static var previews: some View {
////        FilterView(appliedFilters: .constant(0))
//    }
//}
