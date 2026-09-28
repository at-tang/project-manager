//
//  NoteSorting.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-28.
//
import SwiftUI

struct NoteSorting: View {
    
    @Bindable var category: Category;
    
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
        
        Text("Sort By: ").bold()
        
        HStack () {
            
            Button () {sortByPriority()} label: {
                Label("Priority", systemImage: "exclamationmark.viewfinder").labelStyle(.titleAndIcon)
            }.buttonStyle(.borderedProminent).controlSize(.mini)
            
            Button () {sortByDate()} label: {
                Label("Date", systemImage: "calendar").labelStyle(.titleAndIcon)
            }.buttonStyle(.borderedProminent).controlSize(.mini)
            
            Button () {sortByDate()} label: {
                Label("Alpha", systemImage: "character.text.justify").labelStyle(.titleAndIcon)
            }.buttonStyle(.borderedProminent).controlSize(.mini)
            
            
            
            
            
     
        }.padding(.bottom, 8)
        
    }
}
