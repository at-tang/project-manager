import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        ProjectListView()
    }
}

enum AppRoute: Hashable {
    case first
    case second
    case main
}

struct OverlayView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 16) {
                    NavigationLink("First View", value: AppRoute.first)
                    NavigationLink("Second View", value: AppRoute.second)
                    NavigationLink("MainView", value: AppRoute.main)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Select")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .first:
                    Text("First View")
                case .second:
                    Text("Second View")
                case .main:
                    ProjectListView()
                }
            }
        }
    }
}





struct FirstView: View {
    var body: some View {
        ZStack(alignment: .leading){
            Color.gray.opacity(0.1)
            VStack(alignment: .leading, spacing: 8) {
                
                VStack(spacing: 16){
                    OverlayView()
                    Text("Stock Text")
                }.frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.2)).cornerRadius(20)
                    
                Text("Horizontal").font(.largeTitle).fontDesign(.serif)

                Text("Very horizontal")
                
                Text("Testing!").padding(20).background(.blue.opacity(0.5)).cornerRadius(16)
                
                Spacer()
            }.padding(16)

            
        }.frame(maxWidth: .infinity)
    }
}

struct SecondView: View {
    @State var count = 0;
    @State var words = "";
    
    func test () {
        count += 1;
    }
    
    var body: some View {
        ZStack() {
            VStack(){
                Text("Test")
                Button("Increment \(count)") {test()}
                TextEditor(text: $words).fontDesign(.serif).border(Color.blue.opacity(0.1)).frame(maxWidth: 200)
                Spacer()
            }.padding(2).background(.blue.opacity(0.5)).frame(width: .infinity)
        }.frame(width: .infinity, height: .infinity).background(.blue.opacity(0.5))
    }
}

struct ListView: View {
    var body: some View {
        ZStack() {
            VStack() {
                
            }
        }
    }
}

#Preview {
    ProjectListView()
        .modelContainer(previewContainer)
}

@MainActor
private var previewContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Project.self, Category.self, Note.self,
            configurations: config
        )
        return container
    } catch {
        fatalError("Failed to create preview container: \(error)")
    }
}()


