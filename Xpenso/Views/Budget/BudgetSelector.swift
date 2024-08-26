//
//  BudgetSelector.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 07/07/24.
//

import SwiftUI
import SwiftData

struct BudgetSelector : View {
    
    @Binding var showBudgetSelector : Bool
//    var viewModel : BudgetViewModel
    var budgetStyle : BudgetStyle
    var onSelect : (Budget) -> Void
    let budgetService : BudgetService = BudgetServiceImpl()

//    init(showBudgetSelector: Binding<Bool>, budgetStyle : BudgetStyle, onSelect: @escaping (Budget)->Void) {
//        self._showBudgetSelector = showBudgetSelector
//        self.budgetStyle = budgetStyle
//        viewModel = BudgetViewModel(
//            budgetService: budgetService,
//            context: .init(DatabaseHelper.shared.getContainer()))
//        self.onSelect  = onSelect
//    }
    
    
    var body: some View {
        VStack {
            List {
                ForEach(Budget.sampleBudgets()) { budget in
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image("moneyBag", bundle:nil)
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width:18, height: 18)
                                
                                    .foregroundStyle(budget.budgetType == .daily ? Color.yellow : budget.budgetType == .weekly ? Color.blue : Color.green)
                                
                                    .font(.title2)
                                    .padding(.bottom, 8)
                                
                                /*@START_MENU_TOKEN@*/Text(budget.budgetTitle)/*@END_MENU_TOKEN@*/
                                    .font(.title2)
                                    .padding(.bottom, 8)
                                
                            }
                            Text("\(budget.amount, specifier: "%.2f")")
                                .font(.title3)
                            
                        }
                        .padding(.vertical, 8)
                        
                        Spacer()
                    }
                    .onTapGesture {
                        onSelect(budget)
                        showBudgetSelector.toggle()
                    }
                }
            }
        }
    }
}

//#Preview {
//    
//    let config = ModelConfiguration(isStoredInMemoryOnly: true) // Store the container in memory since we don't actually want to save the preview data
//    let container = try! ModelContainer(for: Budget.self, configurations: config)
//   
//    return BudgetSelector(showBudgetSelector: .constant(true), onSelect: {_ in
//        //
//    })
//}
