//
//  CommentService.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 01/09/24.
//

import Foundation
import SwiftData

protocol CommentService : AnyObject {
    
    func addComment(comment: Comment) -> Bool
    func getExpenseComments(expense: Expense) -> [Comment]
    func getBudgetComments(budget: Budget) -> [Comment]
    func deleteComment(comment: Comment) -> Bool
}

class CommentServiceImpl : CommentService {
    func getExpenseComments(expense: Expense) -> [Comment] {
        let context = DatabaseHelper.shared.getModelContext()
        let expenseId = expense.entityId
        let predicate = #Predicate<Comment> { $0.commentParentId == expenseId && $0.commentParentType == "expense"}
        let fetchDesc = FetchDescriptor(predicate: predicate)
        do {
            let comments = try context.fetch(fetchDesc)
            return comments
        }
        catch {
            Logger.log(.error, error.localizedDescription)
            return []
        }
    }
    
    func getBudgetComments(budget: Budget) -> [Comment] {
        let context = DatabaseHelper.shared.getModelContext()
        let budgetId = budget.budgetId
        let predicate = #Predicate<Comment> { $0.commentParentId == budgetId && $0.commentParentType == "budget"}
        let fetchDesc = FetchDescriptor(predicate: predicate)
        do {
            let comments = try context.fetch(fetchDesc)
            return comments
        }
        catch {
            Logger.log(.error, error.localizedDescription)
            return []
        }
    }
    
    func addComment(comment: Comment) -> Bool {
        let context = DatabaseHelper.shared.getModelContext()
        context.insert(comment)
        do {
            try context.save()
            return true
        }
        catch {
            Logger.log(.error, error.localizedDescription)
            return false
        }
    }
     
    func deleteComment(comment: Comment) -> Bool {
        let context = DatabaseHelper.shared.getModelContext()
        context.delete(comment)
        do {
            try context.save()
            return true
        }
        catch {
            Logger.log(.error, error.localizedDescription)
            return false
        }
    }

    
}
