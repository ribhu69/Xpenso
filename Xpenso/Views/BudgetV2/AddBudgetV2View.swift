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
    var onTap: () -> Void
    var body: some View {
        HStack {
            image.resizable()
                .renderingMode(.template)
                .foregroundStyle(.secondary)
                .frame(width: 48, height: 48)
                .padding(.leading, 8)

            VStack(alignment: .leading) {
                Text("\(title)")
                    .setCustomFont(fontName: "Quicksand-SemiBold", size: UIFont.preferredFont(forTextStyle: .title2).pointSize)
                    .padding(.bottom, 8)
                    .padding(.top, 16)
                Text("\(subTitle)")
                    .setCustomFont(fontName: "Quicksand-SemiBold", size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 16)
            }
            .padding(.leading, 8)
            .padding(.trailing, 16)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(isSelected ? Color.blue : Color.gray.opacity(0.8), lineWidth: 2)
                .foregroundStyle(.clear)
        }
        .padding(.horizontal, 4)
        .onTapGesture {
            onTap()
        }
    }
}

import SwiftUI

struct AddBudgetV2View: View {
    @State private var selectedBudget: String?
    @State var optionSelected = false
    @Environment(\.dismiss) var dismiss
    var viewModel : BudgetViewModel


    init(viewModel: BudgetViewModel) {
        self.viewModel = viewModel
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Quicksand-SemiBold", size: UIFont.labelFontSize)!
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Quicksand-SemiBold", size: 34)!
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
                        isSelected: selectedBudget == "Periodic",
                        onTap: {
                            selectedBudget = "Periodic"
                            optionSelected = true
                        }
                    )
                    .padding(.bottom, 8)
                    .padding(.top, 16)

                    BudgetCardView(
                        title: "Adhoc Budget",
                        image: Image("scooter", bundle: nil),
                        subTitle: "Plan a budget for specific events or trips. Manage your expenses for special occasions.",
                        isSelected: selectedBudget == "Adhoc",
                        onTap: {
                            selectedBudget = "Adhoc"
                            optionSelected = true
                        }
                    )

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
                                .foregroundStyle(.primary)
                                .setCustomFont(weight: .semibold, size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                                .foregroundStyle(Color.primary)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 8)
                        }
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                )
                .padding(.horizontal)
            } else {
                HStack {
                    Text("Continue")
                        .foregroundStyle(.secondary)
                        .setCustomFont(weight: .semibold, size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)
                }
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

//#Preview {
//    AddBudgetV2View()
//}
