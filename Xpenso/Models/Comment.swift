//
//  Comment.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 01/09/24.
//

import Foundation
import SwiftData

@Model
final class Comment {
    var commentId: String
    var commentParentId: String
    var commentParentType : String // either budget or expense
    var comment: String
    var createdTime : Date
    
    init(commentId: String, commentParentId: String, commentParentType: String, comment: String, createdTime: Date) {
        self.commentId = commentId
        self.commentParentId = commentParentId
        self.commentParentType = commentParentType
        self.comment = comment
        self.createdTime = createdTime
    }
}

extension Comment {
    static var sampleComent = Comment(commentId: UUID().uuidString, commentParentId: Expense.singleExpense.entityId, commentParentType: "expense", comment: "Blah", createdTime: Date())
}
