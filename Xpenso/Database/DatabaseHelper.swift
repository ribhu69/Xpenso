//
//  DatabaseHelper.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import SwiftData

class DatabaseHelper {
    
    static let shared = DatabaseHelper()
    var context : ModelContext
    var sharedContainer: ModelContainer = {
        let schema = Schema([
            Expense.self, Budget.self, Comment.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }

    }()
    private init() {
        self.context = .init(sharedContainer)
    }

    func getModelContext() -> ModelContext {
        return context
    }
    
    func getContainer() -> ModelContainer {
        return sharedContainer
    }
}
