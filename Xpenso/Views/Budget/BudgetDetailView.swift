////
////  BudgetDetailView.swift
////  Xpenso
////
////  Created by Arkaprava Ghosh on 20/06/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct PieSlice: Shape {
//    var startAngle: Angle
//    var endAngle: Angle
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let center = CGPoint(x: rect.midX, y: rect.midY)
//        path.move(to: center)
//        
//        let adjustedStartAngle = startAngle - Angle.degrees(90)
//        let adjustedEndAngle = endAngle - Angle.degrees(90)
//        
//        path.addArc(center: center, radius: rect.width / 2, startAngle: adjustedStartAngle, endAngle: adjustedEndAngle, clockwise: false)
//        
//        return path
//    }
//}
//
//struct PieChartView: View {
//    var total: Double
//    @State var spend: Double
//    @State private var endAngle = Angle(degrees: 0)
//    @State private var timer: Timer?
//
//
//    var body: some View {
//        let percentage = spend / total
//        let targetAngle = Angle(degrees: 360 * percentage)
//
//        
//        return ZStack {
//            PieSlice(startAngle: .degrees(0), endAngle: .degrees(360))
//                .fill(spend == 0 ? Color.green : Color.gray.opacity(0.3))
//            PieSlice(startAngle: .degrees(0), endAngle: spend <= total ? endAngle : Angle(degrees: 360))
//                .fill(spend < total / 2 ? .green : spend < total * 0.75 ? .yellow : .red)
//
//                .shadow(radius: 2)
//                .onAppear {
//                    withAnimation(.easeIn(duration: 5)) {
//                        startAnimation(to: targetAngle)
//                    }
//                }
//        }
//    }
//    
//    private func startAnimation(to targetAngle: Angle) {
//            let duration: TimeInterval = 1.0
//            let step: TimeInterval = 0.01
//            let steps = duration / step
//            let angleIncrement = targetAngle.degrees / steps
//            
//            timer = Timer.scheduledTimer(withTimeInterval: step, repeats: true) { _ in
//                withAnimation(.easeOut(duration: step)) {
//                    if endAngle.degrees + angleIncrement >= targetAngle.degrees {
//                        endAngle = targetAngle
//                        timer?.invalidate()
//                        timer = nil
//                    } else {
//                        endAngle = Angle(degrees: endAngle.degrees + angleIncrement)
//                    }
//                }
//            }
//        }
//}
//
////struct BudgetDetailView : View {
////    var budget: Budget
////    var mappedExpenses = [Expense]()
////    var dateformatter = DateFormatter()
////    
////    @State private var spentAmount : Double = 45
////    @State private var pieChartSize: CGFloat = 0
////    @State private var chairRotation: Angle = .degrees(0)
//////        @State private var pieChartRotation: Angle = .degrees(0)
////    @State var toggleValue = false
////    @State private var timer: Timer?
////
////    var body: some View {
////        VStack {
////            
////            if mappedExpenses.isEmpty {
////                
////                VStack {
////                    HStack {
////                        if spentAmount != 0 {
////                            PieChartView(total: budget.amount, spend: spentAmount)
////                                .frame(width: pieChartSize, height: pieChartSize)
//////                                .rotationEffect(pieChartRotation)
////                                .onAppear {
////                                    withAnimation(.smooth(duration: 0.8)) {
////                                                                    pieChartSize = 75
////                                                                }
////                                }
////                        }
////                        
////                        VStack(alignment: .leading) {
////                            Text(budget.budgetTitle)
////                                .font(.title2)
////                                .padding(.bottom, 8)
////                            Text("\(budget.amount, specifier: "%.2f")")
////                                .font(.title3)
////                            
////                            if let startDate = budget.startDate {
////                                HStack {
////                                    Image("calender", bundle: nil)
////                                        .resizable()
////                                        .renderingMode(.template)
////                                        .frame(width: 20, height: 20)
////                                        .foregroundStyle(.secondary)
////                                    Text("\(formattedDate(date: startDate))")
////                                        .font(.subheadline)
////                                        .foregroundStyle(.secondary)
////                                    
////                                    Text("-")
////                                        .foregroundStyle(.secondary)
////                                    
////                                    if budget.budgetStyle == .periodic, let endDate = budget.endDate {
////                                        switch budget.budgetType {
////                                        case .daily:
////                                            Text("\(formattedDate(date: endDate))")
////                                                .font(.subheadline)
////                                                .foregroundStyle(.secondary)
////                                        case .weekly:
////                                            Text("\(formattedDate(date: endDate))")
////                                                .font(.subheadline)
////                                                .foregroundStyle(.secondary)
////                                        case .monthly:
////                                            Text("\(formattedDate(date: endDate))")
////                                                .font(.subheadline)
////                                                .foregroundStyle(.secondary)
////                                        case .none:
////                                            Text("")
////                                                .font(.subheadline)
////                                                .foregroundStyle(.secondary)
////                                        }
////                                    }
////                                }
////                            }
////
////                        }
////                        .padding(.leading, 8)
////                        Spacer()
////                    }
////                    Spacer()
////                    
////                    Image("emptyChair", bundle: nil)
////                        .resizable()
////                        .renderingMode(.template)
////                        .foregroundStyle(Color.brown)
////                        .rotationEffect(chairRotation, anchor: .bottom)
////                        
////                        .frame(width: 80, height: 80)
////                    
////                        .onAppear(perform: {
////                            startTimer()
////                        })
////                    
////                        
////                        
////                    Text("No expenses yet, your chair is still empty!")
////                        .textCase(.none)
////                        .multilineTextAlignment(.center)
////                        .font(.title2)
////                        .padding(.bottom, 8)
////                    
////                    Button(action: {
////                                // Add your action here
////                            }) {
////                                Label("Add Expense", systemImage: "plus")
////                                    .padding(.all, 8)
////                                    .background(
////                                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
////                                            .fill(Color.blue) // Change the color as needed
////                                    )
////                            }
////                            .foregroundColor(.white)
////                    
////                    Spacer()
////                }
////              
////              
////            }
////            else {
////                List {
////                    Section {
////                        HStack {
////                            PieChartView(total: 10000, spend: 2345)
////                                .frame(width: pieChartSize, height: pieChartSize)
////                                .onAppear {
////                                    withAnimation(.smooth(duration: 0.8)) {
////                                                                    pieChartSize = 75
////                                                                }
////                                }
////                            
////                            VStack(alignment: .leading) {
////                                Text(budget.budgetTitle)
////                                    .font(.title2)
////                                    .padding(.bottom, 8)
////                                Text("\(budget.amount, specifier: "%.2f")")
////                                    .font(.title3)
////                                
////                                if let startDate = budget.startDate {
////                                    HStack {
////                                        Image("calender", bundle: nil)
////                                            .resizable()
////                                            .renderingMode(.template)
////                                            .frame(width: 20, height: 20)
////                                            .foregroundStyle(.secondary)
////                                        Text("\(formattedDate(date: startDate))")
////                                            .font(.subheadline)
////                                            .foregroundStyle(.secondary)
////                                        
////                                        Text("-")
////                                            .foregroundStyle(.secondary)
////                                        
////                                        if budget.budgetStyle == .periodic, let endDate = budget.endDate {
////                                            switch budget.budgetType {
////                                            case .daily:
////                                                Text("\(formattedDate(date: endDate))")
////                                                    .font(.subheadline)
////                                                    .foregroundStyle(.secondary)
////                                            case .weekly:
////                                                Text("\(formattedDate(date: endDate))")
////                                                    .font(.subheadline)
////                                                    .foregroundStyle(.secondary)
////                                            case .monthly:
////                                                Text("\(formattedDate(date: endDate))")
////                                                    .font(.subheadline)
////                                                    .foregroundStyle(.secondary)
////                                            case .none:
////                                                Text("")
////                                                    .font(.subheadline)
////                                                    .foregroundStyle(.secondary)
////                                            }
////                                        }
////                                    }
////                                }
////
////                            }
////                            .padding(.leading, 8)
////                            Spacer()
////                        }
////                    }
////                    .listSectionSeparator(.hidden)
////                    
////                       
////                        ForEach(mappedExpenses) { expense in
////                            ExpenseRow(expense: expense)
////                                .swipeActions {
////                                    Button(role: .destructive) {
////                                      //  deleteExpense(expense)
////                                    } label: {
////                                        Image("delete", bundle: nil)
////                                            .renderingMode(.template) // Apply rendering mode
////                                    }
////                                }
////                        } .listRowSeparator(.hidden)
////
////                    
////                }.listStyle(.plain)
////            }
////        
////            
////               
////            
////        }
////        .padding(.horizontal, 8)
////        .navigationBarTitleDisplayMode(.inline)
////        
////    }
////    
////    private func startTimer() {
////            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
////                withAnimation(.easeInOut(duration: 1)) {
////                    toggleValue.toggle()
////                    chairRotation = toggleValue ? Angle(degrees: 10) : Angle(degrees: -10)
////                }
////            }
////        }
////}
////
////#Preview {
////    let config = ModelConfiguration(isStoredInMemoryOnly: true) // Store the container in memory since we don't actually want to save the preview data
////    let container = try! ModelContainer(for: Budget.self, configurations: config)
////   
////    return BudgetDetailView(budget: Budget.singularBudgetSample())
////}
