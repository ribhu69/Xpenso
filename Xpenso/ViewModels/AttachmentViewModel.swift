//
//  AttachmentViewModel.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/09/24.
//

import Foundation
import PDFKit


class AttachmentViewModel : ObservableObject  {
    
    private var entityId: String
    private var entityType: String
    private var attachmentService : AttachmentService
    
    
    init(
        entityId: String,
        entityType: String,
        attachmentService: AttachmentService
    ) {
        self.entityId = entityId
        self.entityType = entityType
        self.attachmentService = attachmentService
        
    }
    
    @Published private(set) var selectedAttachments = [Attachment]()
    
    //Use this to create your attachment and append it back to the selectedAttachments
    func insertAttachment(
        attachmentData: Data,
        attachmentType: AttachmentType
    ) {
      
        let attachment = Attachment(
            attachmentId: UUID().uuidString,
            parentId: entityId,
            parentType: entityType,
            attachmentData: attachmentData,
            attachmentType: attachmentType
        )
        selectedAttachments.append(attachment)
    }
    
    func deleteAttachment(attachment: Attachment) {
        
        if let index = selectedAttachments.firstIndex(where: { $0.attachmentId == attachment.attachmentId }) {
            selectedAttachments.remove(at: index)
        }
        Task {
            _ = await attachmentService.deleteAttachment(attachmentId: attachment.attachmentId, parentId: entityId, parentType: entityType)
        }
        
    }
    
    func getFileMetadata(from url: URL) throws -> [FileAttributeKey: Any] {
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            return attributes
        }
    func addFile(filetype: AttachmentType, data: Data) {
        insertAttachment(attachmentData: data, attachmentType: filetype)
    }
    
    func generateUniqueString() -> UUID {
        return UUID()
    }
    
    func handleFile(at url: URL) {
            do {
                let accessing = url.startAccessingSecurityScopedResource()
                let data = try Data(contentsOf: url)
                let attachmentType = AttachmentType(stringValue: url.pathExtension.lowercased())
                
                switch attachmentType {
                case .mp3:
                    insertAttachment(attachmentData: data, attachmentType: .mp3)
                    
                case .mp4:
                    insertAttachment(attachmentData: data, attachmentType: .mp4)

                case .mov:
                    insertAttachment(attachmentData: data, attachmentType: .mov)

                case .heic:
                    insertAttachment(attachmentData: data, attachmentType: .heic)

                case .jpeg:
                    insertAttachment(attachmentData: data, attachmentType: .jpeg)

                case .jpg:
                    insertAttachment(attachmentData: data, attachmentType: .jpg)

                case .png:
                    insertAttachment(attachmentData: data, attachmentType: .png)
                   
                case .pdf:
                    insertAttachment(attachmentData: data, attachmentType: .pdf)
                }
                
                if accessing {
                  url.stopAccessingSecurityScopedResource()
                }
            } catch {
                Logger.log(.error, "Unable to access this file type or this file type might be unsupported")
            }
        }
    
    func saveAttachments() async -> Bool {
        selectedAttachments.forEach { attachment in
                attachment.parentId = entityId
                attachment.parentType = entityType
            }
    
       let status = await attachmentService.saveAttachments(attachments: selectedAttachments)
       return status
    }
}
