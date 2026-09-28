//
//  Rubric.swift
//  Rubric
//
//  Created by Aidan Tang on 2026-09-27.
//

import WidgetKit
import SwiftData
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
    


//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct RubricEntryView : View {
    var entry: Provider.Entry
    
    func getLatestProject () -> Project {
        do {
            let context = ModelContext(try ModelContainer(for: Project.self))
            let projects = try context.fetch(FetchDescriptor<Project>());
            
            if (projects.isEmpty) {return Project()}
            
            var sortedProjects = projects.sorted{$0.dateLastModified > $1.dateLastModified}
            return sortedProjects[0]
        }
        catch {
            return Project()
        }
    }
    
    func getTotalNotes (project: Project) -> Int {
        var total: Int = 0;
        for (index, category) in project.categories.enumerated() {
            total += category.notes.count
        }
        return total;
    }
    


    var body: some View {
        if (getLatestProject().name == "") {
            VStack (alignment: .center) {
                Text("Create a Project to access it here!").fontDesign(.serif).bold().multilineTextAlignment(.center)
                
                Button () {} label: {
                    Label("Add", systemImage: "briefcase")
                }
                
            }.widgetURL(URL(string: "")).controlSize(.mini)
            
            
        }
        
        else {
            VStack (alignment: .center) {
                Text("\(getLatestProject().name)").font(.title3).fontDesign(.serif).bold()
                
                
                Button () {} label: {
                    Label("\(getTotalNotes(project: getLatestProject())) Tasks", systemImage: "briefcase")
                }
                
            }.widgetURL(URL(string: "\(getLatestProject().name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"))
        }
    }
}

struct Rubric: Widget {
    let kind: String = "Rubric"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            RubricEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    Rubric()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
