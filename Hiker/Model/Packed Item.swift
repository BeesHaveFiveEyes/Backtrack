//
//  Packed Item.swift
//  Hiker
//
//  Created by Alasdair Casperd on 10/12/2023.
//

import SwiftData

@Model
class PackedItem {

    var item: Item? // Inverse of Item.packedItemInstances
    var quantity: Int
    
    var packed: Bool
    var starred: Bool
    
    var trip: Trip?
    
    var categoryPosition: Int
    
    var temporary: Bool
    
    init(quantity: Int = 1, packed: Bool = false, starred: Bool = false, categoryPosition: Int, temporary: Bool = false) {
        self.item = nil
        self.quantity = quantity
        self.packed = packed
        self.starred = starred
        self.trip = nil
        self.categoryPosition = categoryPosition   
        self.temporary = temporary
    }
}

extension PackedItem: Identifiable {}
