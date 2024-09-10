//
//  AddAttachmentView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 03/09/24.
//

import Foundation
import SwiftUI
import FileProvider
import PhotosUI
import Lottie



struct AddAttachmentView: View {
    
    var entityId: String
    var entityType: String
    @Environment(\.dismiss) var dismiss
 
    @ObservedObject private var viewModel : AttachmentViewModel
    @State private var audioPlayer: AVAudioPlayer?
    @State private var selectedPhotoItem : PhotosPickerItem?
    @State private var fileContent: String? = nil
    @State private var showFilePicker = false
    
    @State var showPhotoPicker = false
    @State var showCamera = false
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(
        entityId: String,
        entityType: String
    ) {
        self.entityId = entityId
        self.entityType = entityType
        self.viewModel = AttachmentViewModel(entityId: entityId, entityType: entityType)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.selectedAttachments.isEmpty {
                    List {
                        ForEach(viewModel.selectedAttachments) { attachment in
                            let attachmentImage = getImageName(for: attachment.attachmentType)
                            HStack {
                                Image(attachmentImage, bundle: nil)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .padding(.trailing, 8)
                                    .padding(.leading, 8)
                                Text("\(attachment.attachmentType)")
                                    .padding(.trailing, 8)
                                    .padding(.vertical, 8)
                            }
                            .listRowSeparator(.hidden)
                            .listStyle(.plain)
                            .swipeActions {
                                Button(role: .destructive) {
                                    deleteAttachment(attachment: attachment)
                                } label: {
                                    Image("delete", bundle: nil)
                                        .renderingMode(.template)
                                       
                                    
                                }
                                .tint(Color.red)
                            }
                        }
                    }
                    Menu {
                        Button(action: {
                            // Action for Photos
                            showPhotoPicker.toggle()
                        }) {
                            Label("Photos", systemImage: "photo")
                            
                        }
                        
                        Button(action: {
                            // Action for Camera
                            showCamera.toggle()
                        }) {
                            Label("Camera", systemImage: "camera")
                        }
                        
                        Button(action: {
                            // Action for Files
                            showFilePicker.toggle()
                        }) {
                            Label("Files", systemImage: "doc")
                        }
                    } label: {
                        Text("Attachments")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                else {
                    VStack {
                        Spacer()
                        
                        LottieView(animation: .named("attachment"))
                            .playing()
                            .looping()
                            .frame(width: 80, height: 80)
                        Text("Paw-lease, can you attach those files for me?")
                            .setCustomFont(size: UIFont.preferredFont(forTextStyle: .body).pointSize)
                            .padding(.horizontal, 8)
                        
                        Menu {
                            Button(action: {
                                // Action for Photos
                                showPhotoPicker.toggle()
                            }) {
                                Label("Photos", systemImage: "photo")
                                
                            }
                            
                            Button(action: {
                                // Action for Camera
                                showCamera.toggle()
                            }) {
                                Label("Camera", systemImage: "camera")
                            }
                            
                            Button(action: {
                                // Action for Files
                                showFilePicker.toggle()
                            }) {
                                Label("Files", systemImage: "doc")
                            }
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Add Attachment")
                                    .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title3).pointSize)

                                    .padding(.horizontal, 8)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 1.5)
                                    .foregroundStyle(Color.clear)
                                
                            }
                        }
                        Spacer()
                            
                    }
                }
            }
            .fileImporter(isPresented: $showFilePicker, allowedContentTypes: [.mp3, .heic, .movie, .pdf, .jpeg], onCompletion: { result in
                showFilePicker.toggle()
                switch result {
                case .success(let success):
                    viewModel.handleFile(at: success)
                case .failure(let failure):
                    print(failure)
                }
            })
            .photosPicker(isPresented: $showPhotoPicker, selection: $selectedPhotoItem, matching: .any(of: [.images, .videos]), photoLibrary: .shared())
                .onChange(of: selectedPhotoItem) {
                    showPhotoPicker.toggle()
                    Task {
                        if let localId = selectedPhotoItem?.itemIdentifier {
                            let result = PHAsset.fetchAssets(withLocalIdentifiers: [localId], options: nil)
                            if let asset = result.firstObject,
                                let data = try? await selectedPhotoItem?.loadTransferable(type: Data.self) {
                                switch asset.mediaType {
                                case .image:
                                    viewModel.addFile(filetype: .heic, data: data)
                                case .video:
                                    viewModel.addFile(filetype: .mov, data: data)

                                default : fatalError("Unsupported type")
                                }
                                selectedPhotoItem = nil
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            .navigationTitle("Attachments")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
    
    
    private func getImageName(for attachmentType: String) -> String {
        let type = AttachmentType(stringValue: attachmentType)
        
        switch type {
        case .mp3:
            return "audioFile"
        case .jpeg, .heic, .jpg, .png:
            return "image"
        case .mp4, .mov:
            return "video"
        case .pdf:
            return "pdf"
        }
    }
    
    func deleteAttachment(attachment: Attachment) {
        viewModel.deleteAttachment(attachment: attachment)
    }
    
    private func icon(for type: AttachmentTypes) -> String {
        switch type {
        case .camera:
            return "camera"
        case .fileSystem:
            return "fileSystem"
        case .photoLibrary:
            return "gallery"
        }
    }
    
    private func tintColor(for type: AttachmentTypes) -> Color {
        switch type {
        case .camera:
            return Color(hex: "#a2b263")
        case .fileSystem:
            return Color(hex: "#aab234")
        case .photoLibrary:
            return Color(hex: "#b6234")
            
        }
    }
    
    private func title(for type: AttachmentTypes) -> String {
        switch type {
        case .camera:
            return "Camera"
        case .fileSystem:
            return "Files"
        case .photoLibrary:
            return "Photos"
        }
    }
    
    private func performAction(for type: AttachmentTypes) {
        switch type {
        case .camera:
            showCamera.toggle()
        case .fileSystem:
            showFilePicker.toggle()
        case .photoLibrary:
            showPhotoPicker.toggle()
        }
    }
    
    
}
//
//#Preview {
//    AddAttachmentView()
//}
