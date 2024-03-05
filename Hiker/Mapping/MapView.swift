//
//  MapView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 11/12/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map(interactionModes: []) {
            Marker(coordinate: .init(latitude: 43.418, longitude: -1.787)) {
                Label("Trail Start", systemImage: "flag")
            }
            Marker(coordinate: .init(latitude: 42.485, longitude: 3.150)) {
                Label("Trail End", systemImage: "flag")
            }
        }
    }
}

#Preview {
    MapView()
}
