//
//  Units.swift
//  Hiker
//
//  Created by Alasdair Casperd on 28/11/2023.
//

import Foundation

enum DistanceUnit: String, Codable, Hashable {
    case kilometers = "km"
    case miles = "mi"
}

enum WeightUnit: String, Codable, Hashable {
    case grams = "g"
    case kilograms = "kg"
    case ounces = "oz"
    case pounds = "lb"
}

