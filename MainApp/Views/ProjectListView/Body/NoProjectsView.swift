//
//  NoProjectsView.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-28.
//
import SwiftUI

struct NoProjectsView: View {
    
    var body: some View {
        Spacer()
        Image(systemName: "exclamationmark.bubble.fill").resizable().scaledToFit().frame(width: 150, height: 150).opacity(0.3)
        Text("No projects found! Create a new one?").padding(.bottom, 8).bold()
        AddProjectButton()
        Spacer()
        
    }
}

