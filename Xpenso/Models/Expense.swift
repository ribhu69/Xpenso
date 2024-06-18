//
//  Expense.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import Foundation

struct Expense : Identifiable {
    var id = UUID()
    var amount: Double
    var category : ExpenseCategory
    var description: String?
    var date: Date?
}

//sample data only
extension Expense {
    static let sampleExpenses: [Expense] = [
        Expense(amount: 45.0, category: .groceries, description: "Weekly groceries", date: Date()),
        Expense(amount: 120.0, category: .diningOut, description: "Dinner at restaurant", date: Date()),
        Expense(amount: 300.0, category: .education, description: "Online course", date: Date()),
        Expense(amount: 50.0, category: .entertainment, description: "Movie tickets", date: Date()),
        Expense(amount: 100.0, category: .clothing, description: "New jacket", date: Date()),
        Expense(amount: 200.0, category: .healthcare, description: "Medical check-up", date: Date()),
        Expense(amount: 900.0, category: .housing, description: "Monthly rent", date: Date()),
        Expense(amount: 40.0, category: .miscellaneous, description: "Gift for a friend", date: Date()),
        Expense(amount: 150.0, category: .savings, description: "Monthly savings", date: Date()),
        Expense(amount: 60.0, category: .transportation, description: "Gasoline", date: Date()),
        Expense(amount: 100.0, category: .utilities, description: "Electricity bill", date: Date()),
        Expense(amount: 30.0, category: .none, description: "Random expense", date: Date()),
        // Add more sample expenses
        Expense(amount: 80.0, category: .groceries, description: "Household items", date: Date()),
        Expense(amount: 200.0, category: .diningOut, description: "Family dinner", date: Date()),
        Expense(amount: 50.0, category: .education, description: "Textbooks", date: Date()),
        Expense(amount: 80.0, category: .entertainment, description: "Concert tickets", date: Date()),
        Expense(amount: 70.0, category: .clothing, description: "Shoes", date: Date()),
        Expense(amount: 150.0, category: .healthcare, description: "Dentist visit", date: Date()),
        Expense(amount: 950.0, category: .housing, description: "Rent", date: Date()),
        Expense(amount: 30.0, category: .miscellaneous, description: "Magazine subscription", date: Date()),
        Expense(amount: 200.0, category: .savings, description: "Investment", date: Date()),
        Expense(amount: 40.0, category: .transportation, description: "Public transport", date: Date()),
        Expense(amount: 80.0, category: .utilities, description: "Water bill", date: Date()),
        // Add more expenses as needed
        Expense(amount: 50.0, category: .clothing, description: "T-shirt", date: Date()),
        Expense(amount: 25.0, category: .diningOut, description: "Lunch with friends", date: Date()),
        Expense(amount: 150.0, category: .education, description: "School supplies", date: Date()),
        Expense(amount: 40.0, category: .entertainment, description: "Video game", date: Date()),
        Expense(amount: 80.0, category: .groceries, description: "Snacks", date: Date()),
        Expense(amount: 120.0, category: .healthcare, description: "Prescription medication", date: Date()),
        Expense(amount: 300.0, category: .housing, description: "Utility bill", date: Date()),
        Expense(amount: 60.0, category: .miscellaneous, description: "Charity donation", date: Date()),
        Expense(amount: 200.0, category: .savings, description: "Retirement fund", date: Date()),
        Expense(amount: 70.0, category: .transportation, description: "Taxi fare", date: Date()),
        Expense(amount: 90.0, category: .utilities, description: "Internet bill", date: Date()),
        // Add more expenses as needed
    ]
}
