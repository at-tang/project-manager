//
//  ProjectListView.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-25.
//
import SwiftUI
import SwiftData

struct ProjectListView: View {
    @Environment(\.modelContext) private var modelContext;
    @Query(sort: \Project.dateLastModified, order: .reverse) private var projects: [Project]
    
    @State var newTitle = "";
    @State var dateComplete = Date();
    @State var editMode: Bool = false;
    
    @State private var path = NavigationPath()
    
    
    
    var body: some View {
        NavigationStack (path: $path) {
            VStack(spacing: 12) {
                
                Header()
                
                // View for no projects
                if (projects.count == 0) {
                    NoProjectsView()
                }
                // View if at least a project
                else {
                    ProjectList(projects: projects)
                }
                

                
            }.padding(16)
        }.onOpenURL { url in
            let name = url.absoluteString
            // An empty string means that a filler project's name was passed on (can only occur if the user has no projects)
            if (name == "") {
                return
            }
            if let item = try? modelContext.fetch(FetchDescriptor<Project>(predicate: #Predicate { $0.name == name })).first {

                    path.append(item)

            }
        }
        
    }
}
