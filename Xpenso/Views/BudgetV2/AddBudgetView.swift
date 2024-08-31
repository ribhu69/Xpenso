//
//  AddBudgetV2View.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 25/08/24.
//

import SwiftUI

struct BudgetCardView: View {
    var title: String
    var image: Image
    var subTitle: String
    var isSelected: Bool
    var body: some View {
        HStack {
            image.resizable()
                .renderingMode(.template)
                .foregroundStyle(AppTheme.shared.selectedColor)
                .frame(width: 24, height: 24)
                .padding(.leading, 16)

            VStack(alignment: .leading) {
                Text("\(title)")
                    .setCustomFont(fontName: "Manrope-Regular", size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                    .padding(.bottom, 8)
                    .padding(.top, 16)
                Text("\(subTitle)")
                    .setCustomFont(fontName: "Manrope-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 16)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding(.leading, 8)
            .padding(.trailing, 16)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(isSelected ? AppTheme.shared.selectedColor : Color.gray.opacity(0.8), lineWidth: 1)
                .foregroundStyle(.clear)
        }
        .padding(.horizontal, 16)
    }
}

import SwiftUI

struct AddBudgetView: View {
    @State private var selectedBudget: String?
    @State var optionSelected = false
    @Environment(\.dismiss) var dismiss
    var viewModel : BudgetViewModel


    init(viewModel: BudgetViewModel) {
        self.viewModel = viewModel
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Manrope-Regular", size: UIFont.labelFontSize)!
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Manrope-Regular", size: 34)!
        ]
        appearance.backgroundColor = UIColor.systemBackground

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    BudgetCardView(
                        title: "Periodic Budget",
                        image: Image("calender", bundle: nil),
                        subTitle: "Track your expenses throughout your day, week or month. See spending across various categories.",
                        isSelected: selectedBudget == "Periodic")
                    .padding(.bottom, 8)
                    .padding(.top, 16)
                    .onTapGesture {
                        selectedBudget = "Periodic"
                        optionSelected = true
                    }

                    BudgetCardView(
                        title: "Adhoc Budget",
                        image: Image("scooter", bundle: nil),
                        subTitle: "Plan a budget for specific events or trips. Manage your expenses for special occasions.",
                        isSelected: selectedBudget == "Adhoc"
                    )
                    .onTapGesture {
                        selectedBudget = "Adhoc"
                        optionSelected = true
                    }

                    Spacer()
                }
                .navigationTitle("Choose a budget type")
            }
            
            if optionSelected {
                NavigationLink(
                    destination: {
                        if selectedBudget == "Adhoc" {
                            AddABudgetView(budgetStyle: .adhoc) { budget in
                                viewModel.addBudget(budget: budget)
                                dismiss()
                            }
                        } else {
                            AddABudgetView(budgetStyle: .periodic) { budget in
                                viewModel.addBudget(budget: budget)
                                dismiss()
                            }
                        }
                    },
                    label: {
                        HStack {
                            Text("Continue")
                                .foregroundStyle(.white)
                                .setCustomFont(weight: .semibold, size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                               
                            Image(systemName: "arrow.right.circle")
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .background(AppTheme.shared.selectedColor)


                    }
                )
            } else {
                HStack {
                    Text("Continue")
                        .foregroundStyle(.secondary)
                        .setCustomFont(weight: .semibold, size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                       
                        .padding(.vertical, 8)
                    Image(systemName: "arrow.right.circle")
                        .renderingMode(.template)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 12)
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddBudgetView(viewModel: BudgetViewModel(budgetService: BudgetServiceImpl(), context: DatabaseHelper.shared.getModelContext()))
}
