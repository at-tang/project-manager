//
//  RubricLiveActivity.swift
//  Rubric
//
//  Created by Aidan Tang on 2026-09-27.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RubricAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct RubricLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RubricAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension RubricAttributes {
    fileprivate static var preview: RubricAttributes {
        RubricAttributes(name: "World")
    }
}

extension RubricAttributes.ContentState {
    fileprivate static var smiley: RubricAttributes.ContentState {
        RubricAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: RubricAttributes.ContentState {
         RubricAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: RubricAttributes.preview) {
   RubricLiveActivity()
} contentStates: {
    RubricAttributes.ContentState.smiley
    RubricAttributes.ContentState.starEyes
}
