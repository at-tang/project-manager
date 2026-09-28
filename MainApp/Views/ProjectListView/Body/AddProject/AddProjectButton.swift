//
//  AddProjectButton.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-25.
//
import SwiftUI
import SwiftData

struct AddProjectButton: View {
    @Environment(\.modelContext) private var modelContext;
    @State var modalActive: Bool = false;
    
    func activateModal () {
        modalActive = true;
    }

    

    
    var body: some View {
        
        Button (action: activateModal) {
            Label("Create A New Project", systemImage: "folder.badge.plus")
            
        }.buttonStyle(.borderedProminent).controlSize(.large)
            .sheet(isPresented: $modalActive) {
                AddProjectSheet(modalActive: $modalActive)

                    
                }.frame(width: .infinity, height: 32).buttonStyle(.borderedProminent).controlSize(.large)
        }
    
}

