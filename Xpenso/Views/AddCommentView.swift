//
//  AddCommentView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 01/09/24.
//

import Foundation
import SwiftData
import SwiftUI

struct AddCommentView: View {
    var onSave: (String) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var comment = ""

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $comment)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                   
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {  // Place "Save" on the trailing side
                    Button(action: {
                        onSave(comment)
                        dismiss()
                    }) {
                        Text("Save")
                            .bold()
                    }
                }
            }
            .padding(.top, 16) // Adjust padding to avoid overlap
            .navigationTitle("Add Comment")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true) // Store the container in memory since we don't actually want to save the preview data
    let container = try! ModelContainer(for: Expense.self, configurations: config)
    return AddCommentView { stringItem in
        //
    }
}
