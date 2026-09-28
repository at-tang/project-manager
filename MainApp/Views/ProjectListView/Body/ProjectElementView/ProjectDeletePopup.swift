//
//  ProjectDeletePopup.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-25.
//
import SwiftUI
import SwiftData

/*
 The popup window that appears when the user presses
 the delete button, asking for a confirmation.
 */

struct ProjectDeletePopup: View {
    
    @Environment(\.modelContext) private var modelContext;
    @Bindable var project: Project;
    @Binding var deleteWarning: Bool;
 
    func deleteProject() {
        modelContext.delete(project)
        deleteWarning = false
    }
    
    var body: some View {
        VStack() {
            Text("Are you sure you want to delete \(project.name)? This action cannot be undone.")
            Button("Confirm") {deleteProject()}.buttonStyle(.bordered)
        }
    }
}
