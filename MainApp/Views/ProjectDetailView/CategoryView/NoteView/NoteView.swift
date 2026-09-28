//
//  NoteView.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-26.
//
import SwiftUI
import SwiftData
import PhotosUI

struct NoteView: View {
    
    @Environment(\.modelContext) private var modelContext;
    
    @Bindable var note: Note;
    @Binding var editMode: Bool;
    
    @State private var selectedPhoto: PhotosPickerItem?;
    

    
    func translatePriority() -> String {
        if (note.priority == 1) {return "Low"}
        else if (note.priority == 2) {return "Medium"}
        else {return "High"}
    }
    
    var body: some View {
        
        if (editMode) {
            VStack(spacing: 12) {
                
                TextField("Enter the text for this note here!", text: $note.text, axis: .vertical).lineLimit(1...8).padding(8).background(Color(.systemGray6)).cornerRadius(8)
                
                if let imageData = note.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage).resizable().scaledToFit().frame(maxWidth: .infinity)
                    
                }

                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    Label(note.imageData == nil ? "Add Photo" : "Change Photo", systemImage: "photo.badge.plus")
                }.buttonStyle(.bordered)
                
                
                Picker("Priority: ", selection: $note.priority) {
                    Text("Low").foregroundStyle(.green).tag(1).backgroundStyle(.yellow)
                    Text("Medium").foregroundStyle(.yellow).tag(2)
                    Text("High").foregroundStyle(.red).tag(3)
                }.pickerStyle(.menu).padding(8)
                
                Button () {modelContext.delete(note)} label: {
                    Label("Delete", systemImage: "xmark.circle").foregroundStyle(.white)
                }.buttonStyle(.borderedProminent).tint(.red).padding(.top, 6)
                
            }.padding(.vertical, 16)
            
            
                .onChange(of: selectedPhoto) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            note.imageData = data
                        }
                    }
                }
            
        }
        
        else {
            VStack(alignment: .leading) {
                
                if (note.text.isEmpty) {
                    Text("No content was written for this note.").italic().foregroundStyle(.gray.opacity(0.5))
                }
                else {
                    Text(note.text).bold()
                }
                
                if let imageData = note.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage).resizable().scaledToFit().frame(maxWidth: .infinity)
                    
                }
                
                Text("Priority: \(translatePriority())").padding(.top, 8)
                Text("Created on: \(Date(timeIntervalSince1970: TimeInterval(note.dateCreated)).formatted())")
                
                
                
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
