//
//  RubricBundle.swift
//  Rubric
//
//  Created by Aidan Tang on 2026-09-27.
//

import WidgetKit
import SwiftUI

@main
struct RubricBundle: WidgetBundle {
    var body: some Widget {
        Rubric()
        RubricControl()
        RubricLiveActivity()
    }
}
