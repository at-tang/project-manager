import SwiftUI
import SwiftData

@main struct MyApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView().tint(Color.purple)
        }
        .modelContainer(for: [Project.self, Category.self, Note.self])
    }
}
