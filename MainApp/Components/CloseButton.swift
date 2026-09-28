//
//  CloseButton.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-27.
//
import SwiftUI
struct CloseButton: View {
    
    @Binding var close: Bool;
    
    func closeButton () {
        close = false;
    }
    
    var body: some View {
        Button () {closeButton()} label: {
            Image(systemName: "xmark.circle.fill").resizable().scaledToFit().frame(width: 30).tint(.red)
            
        }.buttonStyle(.borderless)
    }
}
