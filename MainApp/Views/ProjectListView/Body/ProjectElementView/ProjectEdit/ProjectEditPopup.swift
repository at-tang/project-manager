//
//  ProjectEditPopup.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-26.
//
import SwiftUI
struct ProjectEditPopup: View {
    @Binding var editWindow: Bool; // Configure modal
    
    @Bindable var project: Project;
    


    
    
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("Edit your Project's Title: ")
            TextField("Enter a new title", text: $project.name).fontDesign(.serif).font(.title)
            
 
            Spacer();
            Button("Close") {editWindow = false}.buttonStyle(.borderedProminent)
        }.padding(24)
        
    }
}
