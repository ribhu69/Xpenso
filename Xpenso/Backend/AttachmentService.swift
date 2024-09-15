//
//  AttachmentService.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 11/09/24.
//

import Foundation
import SwiftData

protocol AttachmentService {
    func getAttachments(expense: Expense) -> [Attachment]
    func saveAttachments(attachments : [Attachment]) async -> Bool
    func deleteAttachment(attachmentId: String, parentId: String, parentType: String) async -> Bool
    func deleteAttachment(attachment: Attachment) async -> Bool
}
class AttachmentServiceImpl : AttachmentService {
    
    func getAttachments(expense: Expense) -> [Attachment] {
        let context = DatabaseHelper.shared.getModelContext()
        
        let parentId = expense.entityId
        let parentType = "expense"
        let predicate = #Predicate<Attachment> { $0.parentId == parentId && $0.parentType == parentType}
        let fetchDesc = FetchDescriptor(predicate: predicate)
        do {
            let attachments = try context.fetch(fetchDesc)
            return attachments
        }
        catch {
            Logger.log(.error, error.localizedDescription)
            return []
        }
    }
    
    func saveAttachments(attachments: [Attachment]) async -> Bool {
        let context = DatabaseHelper.shared.getModelContext()
        
        for attachment in attachments {
            context.insert(attachment)
        }
        do {
            try context.save()
            return true
        }
        catch {
            Logger.log(.error, error.localizedDescription)
            return false
        }
    }
    
    func deleteAttachment(attachmentId: String, parentId: String, parentType: String) async -> Bool {
        let context = DatabaseHelper.shared.getModelContext()
        let predicate = #Predicate<Attachment> { $0.attachmentId == attachmentId && $0.parentId == parentId && $0.parentType == parentType}
        let fetchDesc = FetchDescriptor<Attachment>(predicate: predicate)
        do {
            let attachments = try context.fetch(fetchDesc)
            for attachment in attachments {
                context.delete(attachment)
            }
            try context.save()
            return true
        }
        catch {
            Logger.log(.error, error.localizedDescription)
            return false
        }
    }
    
    func deleteAttachment(attachment: Attachment) async -> Bool {
        let context = DatabaseHelper.shared.getModelContext()
        context.delete(attachment)
        return true
    }
}
