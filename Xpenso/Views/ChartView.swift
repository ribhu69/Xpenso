import Foundation
import Charts
import SwiftUI

struct ChartView: View {
    let expenses: [Expense]
    @State private var selectedGraphOption: GraphOption?
    
    enum GraphOption: String, CaseIterable {
        case byDate = "By Date"
        case byCategory = "By Category"
        case byMonth = "By Month"
        case byYear = "By Year"
    }
    
    var body: some View {
            VStack {
                let categorySums = expenses.reduce(into: [:]) { (counts, expense) in
                    counts[expense.category, default: 0] += expense.amount
                }
                
                
                
                let sortedCategories = categorySums.keys.sorted { categorySums[$0]! > categorySums[$1]! }
                
                Label("The following data shows category based segregation of your expenses", systemImage: "")
                    .foregroundStyle(Color.secondary)
                
                Chart {
                    ForEach(sortedCategories, id: \.self) { category in
                        let totalAmount = categorySums[category] ?? 0
                        
                        LineMark(
                            x: .value("Category", category.rawValue),
                            y: .value("Amount", totalAmount)
                        )
                        
                        
                        PointMark(
                            x: .value("Category", category.rawValue),
                            y: .value("Amount", totalAmount)
                        )
                        .foregroundStyle(by: .value("Category", category.rawValue))
                    }
                }
                .chartXAxis(.visible)
//                .chartYAxis {
//                    AxisMarks(position: .leading)
//                }
                .chartScrollableAxes(.horizontal)
                .padding()
              
        }
            .navigationTitle("Expense Chart")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Menu {
//                        ForEach(GraphOption.allCases, id: \.self) { option in
//                            if option == .byDate {
//                                Button(action: {
//                                    // Show submenu for date options
//                                    selectedGraphOption = option
//                                }) {
//                                    Label(option.rawValue, systemImage: "")
//                                }
//                                .disabled(true) // For demonstration, enable this option
//                            } else if option == .byCategory {
//                                Button(action: {
//                                    selectedGraphOption = option
//                                }) {
//                                    Label(option.rawValue, systemImage: "")
//                                }
//                            }
//                            // Add more options as needed
//                        }
//                    } label: {
//                        Image(systemName: "chart.bar.xaxis")
//                    }
//                }
//            }
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView(expenses: Expense.sampleExpenses)
//    }
//}
