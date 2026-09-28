//
//  AddProjectSheet.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-25.
//
import SwiftUI
import SwiftData

struct AddProjectSheet: View {
    
    @Environment(\.modelContext) private var modelContext;
    @Binding var modalActive: Bool;
    
    @State var hasDateComplete: Bool = false;
    @State var errorText: String = "";
    
    @State var dateComplete: Date = Date();
    @State var newTitle: String = "";
    
    func addProject() {
        var completion: Double = 0;
        if (hasDateComplete) {completion = dateComplete.timeIntervalSince1970}
        
        if (newTitle == "") {
            errorText = "Please enter a title for your new Project."
            return
        }
        
        // Check for duplicate names
        let descriptor = FetchDescriptor<Project>( predicate: #Predicate<Project> {$0.name == newTitle})
        do {
            var count = try modelContext.fetchCount(descriptor)
            
            if (count > 0) { // If duplicate is found
                var title = newTitle;
                errorText = "Project with name \"\(title)\" already exists. Please select another name."
                return
            }
        }
        catch {
            errorText = "Error!"
            return
        }
        
        let newProject = Project(name: newTitle, dateComplete: completion)
        
        modelContext.insert(newProject)
        do {
            try? modelContext.save()
        }
        
        // Reset values
        modalActive = false
        newTitle = ""
        hasDateComplete = false
        errorText = "";
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack() {
                Spacer();
                CloseButton(close: $modalActive)
            }
            
            

            

            TextField("Your Project's Name", text: $newTitle)
                    .font(.title).fontDesign(.serif).fontWeight(.bold)
            Divider()

            

            Toggle("Include a Completion Date? ", isOn: $hasDateComplete)

            
            if (hasDateComplete) {
                DatePicker("Completion Date:", selection: $dateComplete, displayedComponents: [.date])
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button() {addProject()} label: {
                    Label("Submit", systemImage: "printer.inverse")
                }.buttonStyle(.borderedProminent).controlSize(.extraLarge)
                Spacer()
            }
            
            HStack() {
                Spacer()
                Text(errorText).foregroundStyle(.red).bold()
                Spacer()
            }
            
            

        }.padding(24).presentationDetents([.medium])
    }
}

