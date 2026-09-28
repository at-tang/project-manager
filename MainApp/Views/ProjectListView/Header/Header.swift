//
//  Header.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-28.
//
import SwiftUI

struct Header: View {
    
    
    var body: some View {
        
        HStack (alignment: .center) {
            Image(systemName: "books.vertical.circle").resizable().scaledToFit().frame(width: 40)
            Text("My Projects").font(.largeTitle).fontDesign(.serif).fontWeight(.bold)
            Spacer()
            NavigationLink (destination: SettingsView()) {
                Button () {} label: {
                    Image(systemName: "gearshape.fill").resizable().scaledToFit().frame(width: 30)
       
                }
            }

        }
        
        
    }
}

