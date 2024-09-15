import SwiftUI
import SwiftData

struct ExpenseDetailOptionView : View {
    var title: String
    var image: Image
    var action: () -> Void
    var body: some View {
        HStack {
            
            Button(action: action, label: {
                HStack {
                    image
                        .renderingMode(.template)
                        .foregroundStyle(AppTheme.shared.selectedColor.secondary)
                    Text(title)
                        .setCustomFont(weight: .medium)
                        .foregroundStyle(AppTheme.shared.selectedColor)
                }
            })
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 0.8, dash: [5]))
                    .foregroundStyle(Color.gray)
            }
        }
    }
}

struct ExpenseDetailView: View {
    @State var showAddComment = false
    @State var showAttachmentVC = false
    
    @State var comments = [Comment]()
    @State var attachments = [Attachment]()
    
    @State var showDeleteCommentAlert = false
    @State private var commentToDelete : Comment?
    
    @State var showDeleteAttachmentAlert = false
    @State private var attachmentToDelete : Attachment?
    
    var expense: Expense
    @State private var selectedSegment: Int = 0
    let segments = ["Attachments", "Comments"]
    var commentViewModel : CommentService = CommentServiceImpl()
    var attachmentViewModel : AttachmentService = AttachmentServiceImpl()
    
    init(expense: Expense) {
        self.expense = expense
    }
    
    var body: some View {
        
        VStack {
            List {
                Section {
                    VStack {
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(expense.amount, format: .currency(code: "INR"))
                                    .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                                
                                if let desc = expense.desc {
                                    Text("\(desc)")
                                        .lineLimit(0)
                                        .setCustomFont(size: UIFont.preferredFont(forTextStyle: .body).pointSize)
                                        .foregroundStyle(.secondary)
                                }
                                
                                HStack {
                                    Image(expense.category.rawValue, bundle: nil)
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .foregroundStyle(.secondary)
                                    
                                    Image("dot", bundle:nil)
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .rotationEffect(.degrees(90))
                                        .foregroundStyle(Color.secondary)
                                    
                                    Image("calender", bundle: nil)
                                        .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .foregroundStyle(.secondary)
                                    
                                    if let date = expense.date {
                                        Text("\(getFormattedDate(date: date))")
                                    }
                                }
                                
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        
                        Picker("Select an option", selection: $selectedSegment) {
                            ForEach(0..<segments.count) { index in
                                Text(segments[index])
                                    .tag(index)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                    }
                }
                
                if selectedSegment == 1 {
                    if !comments.isEmpty {
                        
                        ForEach(comments) {
                            comment in
                            HStack {
                                Image("comments", bundle: nil)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundStyle(.secondary)
                                    .padding(.trailing, 8)
                                VStack(alignment: .leading) {
                                    Text("\(comment.comment)")
                                        .setCustomFont()
                                        .padding(.bottom, 4)
                                    Text("\(getFormattedDate(date: comment.createdTime))")
                                        .setCustomFont()
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
//                                    deleteComment(comment: comment)
                                    commentToDelete = comment
                                    showDeleteCommentAlert.toggle()
                                } label: {
                                    Image("delete", bundle: nil)
                                        .renderingMode(.template)
                                }
                                .tint(Color.red)
                            }
                        }
                    }
                    else {
                        HStack {
                            
                            Spacer()
                            Image("comments", bundle: nil)
                                .resizable()
                                .frame(width: 18, height: 18)
                            Text("No Comments")
                                .setCustomFont()
                            Spacer()
                            
                        }
                        .padding(.vertical, 8)
                        
                    }
                }
                else {
                    
                    if !attachments.isEmpty {
                        
                        ForEach(attachments) {
                            attachment in
                            AttachmentCell(attachment: attachment)
                                .listRowSeparator(.hidden)
                                .listStyle(.plain)
                                .swipeActions {
                                    Button(role: .destructive) {
//                                        deleteAttachment(attachment: attachment)
                                        attachmentToDelete = attachment
                                        showDeleteAttachmentAlert.toggle()
                                    } label: {
                                        Image("delete", bundle: nil)
                                            .renderingMode(.template)
                                    }
                                    .tint(Color.red)
                                }
                        }
                    }
                    else {
                        HStack {
                            
                            Spacer()
                            Image("attachmens", bundle: nil)
                                .resizable()
                                .frame(width: 18, height: 18)
                            Text("No Attachments")
                                .setCustomFont()
                            Spacer()
                            
                        }
                        .padding(.vertical, 8)
                        
                    }
                }
            }
            
            HStack {
                if selectedSegment == 0 {
                    ExpenseDetailOptionView(title: "Add Attachment", image: Image("attachment", bundle: nil)) {
                        showAttachmentVC.toggle()
                    }
                    
                    .sheet(isPresented: $showAttachmentVC) {
                        AddAttachmentView(
                            entityId: expense.entityId,
                            entityType: "expense") {
                                attachments in
                                self.attachments = attachments
                            }
                        
                    }
                }
                else {
                    ExpenseDetailOptionView(title: "Add Comment", image: Image("comment", bundle: nil)) {
                        showAddComment.toggle()
                    }
                  
                    .sheet(isPresented: $showAddComment) {
                        AddCommentView { comment in
                            
                            let comment = Comment(commentId: UUID().uuidString, commentParentId: expense.entityId, commentParentType: "expense", comment: comment, createdTime: Date())
                            if commentViewModel.addComment(comment: comment) {
                                comments.append(comment)
                            }
                            showAddComment.toggle()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
            .padding(.vertical, 8)
        }
        .alert("Delete Comment", isPresented: $showDeleteCommentAlert, presenting: commentToDelete) { item in
            Button("Cancel", role: .cancel) {
                commentToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let commentToDelete {
                    deleteComment(comment: commentToDelete)

                }
            }
        } message: { item in
            Text("Are you sure you want to this comment?")
        }
        
        
        .alert("Delete Attachment", isPresented: $showDeleteAttachmentAlert, presenting: attachmentToDelete) { item in
            Button("Cancel", role: .cancel) {
                attachmentToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let attachmentToDelete {
                    deleteAttachment(attachment: attachmentToDelete)
                }
            }
        } message: { item in
            Text("Are you sure you want this attachment?")
        }

        .onAppear {
            // Fetch comments and attachments when the view appears
            self.comments = self.commentViewModel.getExpenseComments(expense: expense)
            self.attachments = attachmentViewModel.getAttachments(expense: expense)
        }
        .navigationTitle("Expense Detail")
    }
    
    func deleteComment(comment: Comment) {
        if commentViewModel.deleteComment(comment: comment) {
            if let commentIndex = comments.firstIndex(where: { $0.commentId == comment.commentId}) {
                comments.remove(at: commentIndex)
            }
        }
    }
    
    func deleteAttachment(attachment: Attachment) {
        
        if let attachmentIndex = attachments.firstIndex(where: { $0.attachmentId == attachment.attachmentId }) {
            attachments.remove(at: attachmentIndex)
        }
        Task {
            _ = await attachmentViewModel.deleteAttachment(attachment:attachment)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true) // Store the container in memory since we don't actually want to save the preview data
    let container = try! ModelContainer(for: Expense.self, Comment.self, configurations: config)
    return ExpenseDetailView(expense: Expense.singleExpense)
}
