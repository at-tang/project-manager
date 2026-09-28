//
//  ProjectList.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-28.
//
import SwiftUI
import Observation

struct ProjectList: View {
    
    let projects: [Project]
    
    var body: some View {
        List {
            ForEach(projects) { project in
                ProjectElementView(project: project)
                
                
            }
        }.navigationDestination(for: Project.self) {project in ProjectDetailView(project: project)}.listRowSpacing(16)
        
        Spacer()
        AddProjectButton()
        
        
    }
}

