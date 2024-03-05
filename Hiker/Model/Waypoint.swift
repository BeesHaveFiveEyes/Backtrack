//
//  Waypoint.swift
//  Hiker
//
//  Created by Alasdair Casperd on 12/12/2023.
//

import SwiftData

@Model
class Waypoint {
        
    var label: String
    
    var locationComponents: LocationComponents? = nil
    var locationDescription: String? = nil
    
    var icon: Icon
    var colorComponents: ColorComponents
    
    var details: String
    
    init(label: String = "", locationComponents: LocationComponents? = nil, icon: Icon = .systemName("mappin"), colorComponents: ColorComponents = .fromColor(.red), details: String = "") {
        self.label = label
        self.locationComponents = locationComponents
        self.icon = icon
        self.colorComponents = colorComponents
        self.details = details
    }
}
