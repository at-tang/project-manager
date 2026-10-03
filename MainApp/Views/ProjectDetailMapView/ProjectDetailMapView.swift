//
//  ProjectDetailMapView.swift
//  Rubric
//
//  Created by Aidan Tang on 2026-09-30.
//
import SwiftUI
import MapKit

struct ProjectDetailMapView: View {
    
    @Bindable var project: Project;
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State var totalMarkers = 0;
    
    func updateCameraPosition(note: Note) {
            withAnimation(.easeInOut(duration: 1.0)) {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: note.location.lat, longitude: note.location.long),
                        span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
                    )
                )
            }
        }
    
    func startPositionCamera () {
        for category in project.categories {
            for note in category.notes {
                if (note.location.active) {
                    updateCameraPosition(note: note)
                    return
                }
            }
            
        }
    }
    
    
    var body: some View {
        MapReader () { proxy in
            Map (position: $cameraPosition) {
                
                ForEach(project.categories) { category in
                    ForEach(category.notes) { note in
                        if (note.location.active) {
                            Marker(note.text, coordinate: CLLocationCoordinate2D(latitude: note.location.lat, longitude: note.location.long))
                            
                            
                       
                            
                        }
                        
                        
                    }
                    
                }
                
                

            }.frame(width: .infinity, height: .infinity)
                .onAppear() {
                    startPositionCamera()

                }
        }
        
    }
}

