//
//  ProjectElementView.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-25.
//
import SwiftUI
import SwiftData

struct ProjectElementView: View {
    
    @Environment(\.modelContext) private var modelContext;
    @Bindable var project: Project
    
    // For deletion purposes
    @State var deleteWarning: Bool = false;
    @State var editWindow: Bool = false;
    
    
    // For editing
    
    func openDeleteProjectWindow () {
        deleteWarning = true;
    }
    
    func openEditWindow () {
        editWindow = true;
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationLink("\(project.name)", value: project).font(.title).fontDesign(.serif).bold()
            
            if (project.dateComplete != 0.0) {
                Text("\(Date(timeIntervalSince1970: TimeInterval(project.dateComplete)))").fontDesign(.serif).foregroundStyle(.gray)
                
            }
            
            
            
            HStack () {
                Button() {openEditWindow()} label: {
                    Label("Edit", systemImage: "wrench.and.screwdriver").labelStyle(.titleAndIcon)
                }.buttonStyle(.borderedProminent).controlSize(.small)
                
                Button() {openDeleteProjectWindow()} label: {
                    Label("Delete", systemImage: "trash").labelStyle(.titleAndIcon)
                }.buttonStyle(.borderedProminent).controlSize(.small).tint(.red)
                
                Spacer()
            }
            

            
        }
        .customPopup(isPresented: $deleteWarning) {
            VStack() {
                Text("Do you want to delete this project?")
                Button() {modelContext.delete(project)} label: {
                    Label("Delete \"\(project.name)\"", systemImage: "xmark.circle").labelStyle(.titleAndIcon)
                }.tint(.red).buttonStyle(.borderedProminent)
                
                Button("Close") {deleteWarning = false}.buttonStyle(.borderedProminent)
            }
        }.transition(.opacity)
        
        .customPopup(isPresented: $editWindow) {
            Text("Testing!")
        }
    }
}

