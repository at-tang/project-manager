//
//  CategoryView.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-26.
//
import SwiftUI
import SwiftData
import Observation

@Observable
class CategoryViewConfiguration {
    var editMode: Bool = false;
}

struct CategoryView: View {
    
    @Environment(\.modelContext) private var modelContext;
    
    @Bindable var category: Category
    @Binding var editMode: Bool;

    
    @State var expand: Bool = true;
    @State var deleteConfirm: Bool = false;
    
    func sortByPriority () {
        // Sorts by highest priority first
        category.notes = category.notes.sorted {$0.priority > $1.priority}
    }
    
    func sortByDate () {
        // Sorts by earliest made
        category.notes = category.notes.sorted {$0.dateCreated < $1.dateCreated}
    }
    
    func sortByAlphanumerical () {
        // Sorts by alphabetical order in text
        category.notes = category.notes.sorted {$0.text.localizedCaseInsensitiveCompare($1.text) == .orderedAscending}
    }
    
    
    var body: some View {
        VStack () {
            
            // Header (title and expand) :==============================================
            
            HStack() {
                Button () {expand = !expand} label: {
                    Image(systemName: "\((expand ? "arrowtriangle.down.circle.fill" : "arrowtriangle.right.circle.fill"))").resizable().scaledToFit().frame(width: 20, height: 20)

                }.buttonStyle(.borderless)
                TextField("Enter a name for your category", text: $category.name).font(.title2).fontDesign(.serif).bold().disabled(!editMode)
                
                
            }.padding(.bottom, 8)
            
            // Sorting
            
            if (!editMode && expand) {
                NoteSorting(category: category)
            }
            
    
            
            // Main Body (all the notes)
            if (expand) {
                Divider().overlay(.black)
                LazyVStack() {
                    ForEach(category.notes) { note in
                        NoteView(note: note, editMode: $editMode).padding(.vertical, 16)
                        Divider().overlay(.black)
                    }
                }
                
                
            // Footer
               
            // Expand Less
            if (!editMode) {
                Button () {expand = false} label: {
                    Label("Expand less", systemImage: "arrow.up.folder").labelStyle(.titleAndIcon)
                }.buttonStyle(.borderless)
            }
                
             
            // Add New Note to Category Button
            if (editMode) {
                    Button(" + Add new note") {category.notes.append(Note())}.buttonStyle(.borderless)
                }
            }
            
            Divider().overlay(.black)
            
            // Delete Category Button
            if (editMode) {
                    Button() {deleteConfirm = true} label: {
                        Label("Delete Category", systemImage: "trash.circle.fill").controlSize(.small)
                    }.buttonStyle(.bordered).controlSize(.mini).padding(.vertical, 16)
                        .sheet(isPresented: $deleteConfirm) {
                            VStack(alignment: .center, spacing: 8) {
                                
                                HStack() {
                                    Spacer()
                                    CloseButton(close: $deleteConfirm)
                                }.padding(.bottom, 16)
                                
                                Text("Are you sure you want to delete \"\(category.name)\"?")
                                Button() {modelContext.delete(category); deleteConfirm = false} label: {
                                    Label("Confirm Deletion", systemImage: "doc.on.trash.fill")
                                }.buttonStyle(.borderedProminent)
                            }.padding(24)
                        }.presentationDetents([.medium])

        }
            
            
        }
        
    }

}

