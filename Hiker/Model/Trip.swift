//
//  Trip.swift
//  Hiker
//
//  Created by Alasdair Casperd on 03/10/2023.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Trip {
    
    var name: String
    var icon: Icon
    
    var startDate: Date
    var endDate: Date
    
    var distance: Double
    var distanceUnit: DistanceUnit
    
    var locationDescription: String
    
    var startLocation: LocationComponents? = nil
    var startLocationDescription: String? = nil
    
    var endLocation: LocationComponents? = nil
    var endLocationDescription: String? = nil
    
    var itemsWeightUnit: WeightUnit
    var totalsWeightUnit: WeightUnit
    
    @Relationship(deleteRule: .cascade, inverse: \PackedItem.trip) var packedItems: [PackedItem]
    
    @Relationship(deleteRule: .cascade) var waypoints: [Waypoint]
        
    // Computed properties
    
    var displayName: String {
        return name.filter({$0 != " "}) == "" ? "Unnamed Trip" : name
    }
    
    var displayDistance: String {
        return distance == 0 ? "Unknown" : WeightEngine.display(distance, distanceUnit)
    }
    
    var displayLocation: String {
        return locationDescription.filter({$0 != " "}) == "" ? "Unknown" : locationDescription
    }
    
    var displayDuration: String {
        return "\(Calendar(identifier: .gregorian).numberOfDaysBetween(startDate, and: endDate)) Days"
    }
    
    var displayDate: String {
        return startDate.formatted(Date.FormatStyle().year().month(.wide))
    }
    
    var displayCaption: String {
        if locationDescription.filter({$0 != " "}) != "" {
            return locationDescription
        }
        else {
            return displayDate
        }
    }
    
    init(name: String = "", icon: Icon = .systemName("questionmark.circle"), startDate: Date = .now, endDate: Date = .now.addingTimeInterval(5*24*60*60), distance: Double = 0, distanceUnit: DistanceUnit = .kilometers, locationDescription: String = "", startLocation: LocationComponents? = nil, startLocationDescription: String? = nil, endLocation: LocationComponents? = nil, endLocationDescription: String? = nil, itemsWeightUnit: WeightUnit = .grams, totalsWeightUnit: WeightUnit = .kilograms, packedItems: [PackedItem] = [], waypoints: [Waypoint] = []) {
        self.name = name
        self.icon = icon
        self.startDate = startDate
        self.endDate = endDate
        self.distance = distance
        self.distanceUnit = distanceUnit
        self.locationDescription = locationDescription
        self.startLocation = startLocation
        self.startLocationDescription = startLocationDescription
        self.endLocation = endLocation
        self.endLocationDescription = endLocationDescription
        self.itemsWeightUnit = itemsWeightUnit
        self.totalsWeightUnit = totalsWeightUnit
        self.packedItems = packedItems
        self.waypoints = waypoints
    }
}

extension Trip {
    
    static var sampleTrip: Trip {
        
        let trip = Trip(name: "Snowdonia Way", icon: Icon.text("⛰️"), distance: 192, locationDescription: "North Wales")
        
        var items = [Item]()
        
        items.append(Item(name: "Backpack", weight: 2220))
        items.append(Item(name: "Medium Waterproof Bag", weight: 2220))
        items.append(Item(name: "Backpack", weight: 2220))
        items.append(Item(name: "Backpack", weight: 2220))
                     
        return trip
    }
}
