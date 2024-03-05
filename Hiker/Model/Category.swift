//
//  Category.swift
//  Hiker
//
//  Created by Alasdair Casperd on 04/10/2023.
//

import SwiftUI
import SwiftData

@Model
class Category {
        
    var id: Int
    var name: String
    var notes: String
    var icon: Icon
    
    var colorComponents: ColorComponents
    
    var worn: Bool
    var consumable: Bool
    
    init(id: Int, name: String = "", notes: String = "", icon: Icon = .systemName("tshirt"), colorComponents: ColorComponents = .fromColor(.teal), worn: Bool = false, consumable: Bool = false) {
        self.id = id
        self.colorComponents = colorComponents
        self.name = name
        self.notes = notes
        self.icon = icon
        self.worn = worn
        self.consumable = consumable
    }
}

