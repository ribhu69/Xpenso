//
//  ExpenseListService.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import SwiftData

protocol ExpenseListService : AnyObject {
    func addExpense(expense: Expense) -> Bool
    func getExpenses() -> [Expense]?
    func deleteExpense(expense: Expense) -> Bool
}

final class ExpenseListServiceImpl : ExpenseListService  {
    func addExpense(expense: Expense) -> Bool {
        let context = DatabaseHelper.shared.getModelContext()
        context.insert(expense)
        return true
        
    }
    func getExpenses() -> [Expense]? {
        let context = DatabaseHelper.shared.getModelContext()
        let fetchDescriptor = FetchDescriptor<Expense>()
        do {
            let periodics = try context.fetch(fetchDescriptor)
            Logger.log(.info, "Expense Count: \(periodics.count)")
            return periodics
        }
        catch {
            Logger.log(.error, "No data in expense table")
            return nil
        }
    }
    
    func deleteExpense(expense: Expense) -> Bool {
        let context = DatabaseHelper.shared.getModelContext()
        
        let expenseId = expense.entityId
        let attachmentPredicate = #Predicate<Attachment> { $0.parentId == expenseId  && $0.parentType == "expense"}
        let attachmentFD = FetchDescriptor(predicate: attachmentPredicate)
        let commentPredicae = #Predicate<Comment> { $0.commentParentId == expenseId && $0.commentParentType == "expense"}
        let commentFD = FetchDescriptor(predicate: commentPredicae)
        
        do {
            let comments = try context.fetch(commentFD)
            let attachments = try context.fetch(attachmentFD)
            
            for comment in comments {
                context.delete(comment)
            }
            for attachment in attachments {
                context.delete(attachment)
            }
            
            return true

        }
        catch {
            Logger.log(.error, error.localizedDescription)
            return false
        }
    }
}
