//
//  Item.swift
//  Hiker
//
//  Created by Alasdair Casperd on 04/10/2023.
//

import Foundation
import SwiftData

@Model
class Item {
    
    var name: String
    var category: Category?
    
    var weight: Double
    var weightUnit: WeightUnit
    
    var notes: String
    
    var brand: String
    var condition: String
    var price: String
    
    var consumable: Bool
    var worn: Bool
    
    var example: Bool
    var saved: Bool
    
    var temporary: Bool
    
    @Relationship(inverse: \PackedItem.item) var packedItemInstances: [PackedItem]
    
    var displayWeight: String {
        return WeightEngine.display(weight, weightUnit)
    }
    
    var isEmpty: Bool {
        name == ""
        && weight == 0
        && notes == ""
        && brand == ""
        && condition == ""
        && price == ""
    }
    
    init(name: String = "", category: Category? = nil, weight: Double = 0, weightUnit: WeightUnit = .grams, notes: String = "", brand: String = "", condition: String = "", price: String = "", consumable: Bool = false, worn: Bool = false, example: Bool = false, saved: Bool = true, temporary: Bool = false) {
        self.name = name
        self.category = category
        self.weight = weight
        self.weightUnit = weightUnit
        self.notes = notes
        self.brand = brand
        self.condition = condition
        self.price = price
        self.consumable = consumable
        self.worn = worn
        self.example = example
        self.packedItemInstances = []
        self.saved = saved
        self.temporary = temporary
    }
}

extension Item: Identifiable {}
