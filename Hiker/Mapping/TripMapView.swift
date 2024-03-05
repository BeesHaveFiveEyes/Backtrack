//
//  TripMapView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 28/12/2023.
//

import SwiftUI
import MapKit

struct TripMapView: View {
    var trip: Trip
    
    var body: some View {
        Map(interactionModes: []) {
            if let location = trip.startLocation?.location {
                Marker(coordinate: location) {
                    Label("Start", systemImage: "flag")
                }
            }
            
            if let location = trip.endLocation?.location {
                Marker(coordinate: location) {
                    Label("End", systemImage: "flag")
                }
            }
            
            ForEach(trip.waypoints) { waypoint in
                if let location = waypoint.locationComponents?.location {
                    Marker(coordinate: location) {
                        switch waypoint.icon {
                        case .text(_):
                            Label(waypoint.label, systemImage: "mappin")
                        case .systemName(let systemImage):
                            Label(waypoint.label, systemImage: systemImage)
                        }
                    }
                    .tint(waypoint.colorComponents.color)
                }
            }
        }
    }
}
