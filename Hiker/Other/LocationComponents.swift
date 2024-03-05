//
//  LocationComponents.swift
//  Hiker
//
//  Created by Alasdair Casperd on 11/12/2023.
//

import SwiftUI
import CoreLocation

struct LocationComponents: Codable {
    
    let latitude: Float
    let longitude: Float

    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
    }

    static func fromLocation(_ location: CLLocationCoordinate2D) -> LocationComponents {
        return LocationComponents(latitude: Float(location.latitude), longitude: Float(location.longitude))
    }
}
