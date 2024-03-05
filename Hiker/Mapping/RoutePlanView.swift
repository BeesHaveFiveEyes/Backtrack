//
//  RoutePlanView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 12/12/2023.
//

import SwiftUI
import MapKit

struct RoutePlanView: View {
    
    @Bindable var trip: Trip
    
    var body: some View {
        Form {
            
            Section {
                LocationPicker(label: "Start Point", selection: $trip.startLocation, selectionDescription: $trip.startLocationDescription)
                LocationPicker(label: "End Point", selection: $trip.endLocation, selectionDescription: $trip.endLocationDescription)
            } header: {
                Text("Start and End Points")
            }
            .headerProminence(.increased)
            
            Section {
                ForEach(trip.waypoints) { waypoint in
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            DetailPair(description: waypoint.label, detail: waypoint.locationDescription ?? "")
                        }
                    }
                }
                
                Button {
                    // Add waypoint
                } label: {
                    Text("Add Waypoint")
                }
            } header: {
                Text("Points of Interest")
            }
            .headerProminence(.increased)
            
            Section {
                TripMapView(trip: trip)
                .listRowInsets(EdgeInsets())
                .frame(minHeight: 300)
            }
//            Map {
//                ForEach(trip.waypoints) {waypoint in
//                    if let location = waypoint.location?.location {
//                        Marker(coordinate: location) {
//                            Label(trip.waypoint.name, systemImage: trip.waypoint.systemImage)
//                        }
//                    }
//                }
//            }
//            .listRowInsets(EdgeInsets())
//            .frame(minHeight: 300)
        }
        .navigationBarTitle("Route")
        .toolbar {
            EditButton()
        }
    }
}
