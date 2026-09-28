//
//  ProjectDetailView.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-26.
//

import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    
    @Bindable var project: Project
    
    @State var editMode: Bool = false;

    
    func determineEditModeOn() {
        if (project.categories.count == 0) {
            editMode = true;
        }
        return;
    }
    
    func addNewCategory () {
        if (!editMode) {
            editMode = true
        }
        project.categories.append(Category())
    }
    
    
    var body: some View {
        
        VStack() {
            
            // Title
            HStack(alignment: .center) {
                Spacer()
                Text("\(project.name)").font(.title).bold().fontDesign(.serif)
                Button () {editMode = !editMode} label: {
                    Image(systemName: "\((editMode ? "wrench.and.screwdriver" : "eye"))").resizable().scaledToFit().frame(width: 20)
                }.buttonStyle(.borderedProminent)
                Spacer()
            }
            
            // All Categories
            List () {
                ForEach (project.categories) { category in
                    @State var category: Category = category;
                    
                    CategoryView(category: category, editMode: $editMode)
                    
                }
                
                if (editMode || project.categories.count == 0) {
                    HStack() {
                        Spacer()
                        Button() {addNewCategory()} label: {
                            Label("Add A New Category", systemImage: "folder.badge.plus").labelStyle(.titleAndIcon)
                        }.buttonStyle(.borderedProminent)
                        Spacer()
                    }.listStyle(.sidebar)
                }
                
            }
            

            
            Spacer()
            
        }.padding(.horizontal, 16).listRowSpacing(16)
        
            .onChange(of: project.categories) {
            project.dateLastModified = Date().timeIntervalSince1970 // When a category is modified, also modify the Double dateLastModified to reflect this
        }
    };
        
}

