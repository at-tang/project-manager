//
//  NoteView.swift
//  Untitled Project
//
//  Created by Aidan Tang on 2026-09-26.
//
import SwiftUI
import SwiftData
import PhotosUI
import MapKit

struct NoteView: View {
    
    @Environment(\.modelContext) private var modelContext;
    
    @Bindable var note: Note;
    
    @Binding var editMode: Bool;
    
    // Photos
    @State private var selectedPhoto: PhotosPickerItem?;
    
    // For maps
    @State private var savedLocation: Coordinates?
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State var address: String = "";
    

    

    
    func translatePriority() -> String {
        if (note.priority == 1) {return "Low"}
        else if (note.priority == 2) {return "Medium"}
        else {return "High"}
    }
    
    func updateCameraPosition() {
            withAnimation(.easeInOut(duration: 1.0)) {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: note.location.lat, longitude: note.location.long),
                        span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
                    )
                )
            }
        }
    
    func findLocation () async {
        if (address.isEmpty) {return}
        
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = address
                
            let search = MKLocalSearch(request: request)
            if let response = try? await search.start(),
                let firstItem = response.mapItems.first {
                    
       
                let newCoordinate = firstItem.location.coordinate
                note.location = Coordinates(lat: newCoordinate.latitude, long: newCoordinate.longitude, active: true)
            }
    }
        
        
    
    
    
    var body: some View {
        
        // This will probably be split into two separate Views
        
        if (editMode) {
            VStack(spacing: 12) {
                
                TextField("Enter the text for this note here!", text: $note.text, axis: .vertical).lineLimit(1...8).padding(8).background(Color(.systemGray6)).cornerRadius(8)
                
                
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    Label(note.imageData == nil ? "Add Photo" : "Change Photo", systemImage: "photo.badge.plus")
                }.buttonStyle(.bordered)
                
                if let imageData = note.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage).resizable().scaledToFit().frame(maxWidth: .infinity)
                    
                }

                
                // Map
                
                Button () {
                    withAnimation(.easeInOut(duration: 0.3)) {
                            note.location.active.toggle()
                        }
                }
                label: {
                    Label((note.location.active ? "Remove Map" : "Add Map"), systemImage: "map")
                }.buttonStyle(.bordered)
                
                if (note.location.active) {
                    
                    MapReader () { proxy in
                        Map (position: $cameraPosition) {
                            
                            Marker("", coordinate: CLLocationCoordinate2D(latitude: note.location.lat, longitude: note.location.long))
                            
                            
                        }
                        .frame(width: .infinity, height: 256)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                            .onTapGesture { screenCoord in
                                // Convert screen tap position to map coordinates
                                if let location = proxy.convert(screenCoord, from: .local) {
                                    note.location = Coordinates(lat: location.latitude, long: location.longitude)
                                }
                            }
                            .onChange(of: note.location.lat) {
                                updateCameraPosition()
                            }
                            .onChange(of: note.location.long) {
                                updateCameraPosition()
                            }
                            .onAppear() {
                                updateCameraPosition()
                            }
                        
                    }
                    
                    
                    // Search for location
                    HStack() {
                        TextField("Enter an address here...", text: $address).padding(8).background(Color(.systemGray6)).cornerRadius(8).font(.caption)
                        
                        Button () {Task {await findLocation()}} label: {
                            Label("Search", systemImage: "magnifyingglass").labelStyle(.titleAndIcon)
                        }.buttonStyle(.borderedProminent)
                    }.transition(.opacity.combined(with: .move(edge: .top)))
                }
                
                
                Picker("Priority: ", selection: $note.priority) {
                    Text("Low").foregroundStyle(.green).tag(1).backgroundStyle(.yellow)
                    Text("Medium").foregroundStyle(.yellow).tag(2)
                    Text("High").foregroundStyle(.red).tag(3)
                }.pickerStyle(.menu).padding(8)
            
                
                
                Button () {modelContext.delete(note)} label: {
                    Label("Delete", systemImage: "xmark.circle").foregroundStyle(.white)
                }.buttonStyle(.borderedProminent).tint(.red).padding(.top, 6)
                
            }.padding(.vertical, 16)
            
            
                .onChange(of: selectedPhoto) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            note.imageData = data
                        }
                    }
                }
            
        }
        
        else {
            VStack(alignment: .leading) {
                
                if (note.text.isEmpty) {
                    Text("No content was written for this note.").italic().foregroundStyle(.gray.opacity(0.5))
                }
                else {
                    Text(note.text).bold()
                }
                
                if let imageData = note.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage).resizable().scaledToFit().frame(maxWidth: .infinity)
                    
                }
                
                if (note.location.active) {
                    
                    MapReader () { proxy in
                        Map (position: $cameraPosition) {
                            Marker("", coordinate: CLLocationCoordinate2D(latitude: note.location.lat, longitude: note.location.long))
                        }.frame(width: .infinity, height: 128)
                            .onAppear() {
                                updateCameraPosition()
                            }
                    }
                }

                
                Text("Priority: \(translatePriority())").padding(.top, 8)
                Text("Created on: \(Date(timeIntervalSince1970: TimeInterval(note.dateCreated)).formatted())")
                
                
                
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
