//
//  Popup.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-28.
//
import SwiftUI

struct PopupModifier<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let popupContent: () -> PopupContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isPresented)
            

            if isPresented {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            isPresented = false
                        }
                    }
                

                popupContent()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1) // Keep popup on top
            }
        }
    }
}

extension View {
    func customPopup<PopupContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> PopupContent
    ) -> some View {
        self.modifier(PopupModifier(isPresented: isPresented, popupContent: content))
    }
}

