//
//  Project.swift
//  MyApp
//
//  Created by Aidan Tang on 2026-09-24.
//
import SwiftData
import SwiftUI

struct Coordinates: Codable {
    var lat: Double = 43.65 // Default is Toronto
    var long: Double = -79.38
    var active: Bool = false
    
}

@Model
class Project {
    var name: String
    var dateCreated: Double
    var dateLastModified: Double
    var dateComplete: Double
    var complete: Bool
    
    @Relationship(deleteRule: .cascade, inverse: \Category.project)
    var categories: [Category]
    
    init (name: String = "", dateComplete: Double = 0) {
        self.name = name;
        self.dateCreated = Date().timeIntervalSince1970
        self.dateLastModified = Date().timeIntervalSince1970
        self.dateComplete = dateComplete
        self.categories = [];
        self.complete = false;
    }
}
@Model
class Category {
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Note.category)
    var notes: [Note]
    
    var project: Project?

    
    
    init (name: String = "Untitled Category", project: Project? = nil) {
        self.name = name;
        self.notes = [Note()];
        self.project = project;

    }
}

@Model
class Note {
    var text: String
    var priority: Int
    var active: Bool
    var dateCreated: Double
    var location: Coordinates
    var category: Category?
    
    @Attribute(.externalStorage) var imageData: Data?
    
    init(text: String = "", priority: Int = 1, active: Bool = true, category: Category? = nil, imageData: Data? = nil) {
        self.text = text;
        self.priority = priority;
        self.active = active;
        self.dateCreated = Date().timeIntervalSince1970
        self.location = Coordinates()
        self.category = category;
        self.imageData = imageData;

    }

}


