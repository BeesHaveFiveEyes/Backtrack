//
//  WeightEngine.swift
//  Hiker
//
//  Created by Alasdair Casperd on 26/11/2023.
//

import SwiftUI

struct WeightEngine {
    
    enum WeightType {
        case totalWeight
        case carriedWeight
        case baseWeight
    }
    
    private static func convertToGrams(_ value: Double, from unit: WeightUnit) -> Double {
        switch unit {
        case .grams:
            return value
        case .kilograms:
            return 1000 * value
        case .ounces:
            return value / 0.035274
        case .pounds:
            return value / 0.00220462
        }
    }
    
    private static func convertFromGrams(_ value: Double, to unit: WeightUnit) -> Double {
        switch unit {
        case .grams:
            return value
        case .kilograms:
            return 0.001 * value
        case .ounces:
            return 0.035274 * value
        case .pounds:
            return 0.00220462 * value
        }
    }
    
    static func convertWeightUnit(_ value: Double, from initialUnit: WeightUnit, to finalUnit: WeightUnit) -> Double {
        return convertFromGrams(convertToGrams(value, from: initialUnit), to: finalUnit)
    }
    
    static func display(_ distance: Double, _ unit: DistanceUnit) -> String {
        
        var distanceString = ""
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        
        if distance < 10 {
            formatter.usesSignificantDigits = true
            formatter.maximumSignificantDigits = 2
            formatter.minimumSignificantDigits = 1
            distanceString = formatter.string(from: distance as NSNumber) ?? ""
        }
        else {
            formatter.maximumFractionDigits = 0
            distanceString = formatter.string(from: distance as NSNumber) ?? ""
        }
                
        return distanceString + "\u{00A0}" + unit.rawValue
    }
    
    static func display(_ weight: Double, _ unit: WeightUnit) -> String {
        
        var weightString = ""
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        
        if weight < 10 {
            formatter.usesSignificantDigits = true
            formatter.maximumSignificantDigits = 2
            formatter.minimumSignificantDigits = 1
            weightString = formatter.string(from: weight as NSNumber) ?? ""
        }
        else {
            formatter.maximumFractionDigits = 0
            weightString = formatter.string(from: weight as NSNumber) ?? ""
        }
                
        return weightString + "\u{00A0}" + unit.rawValue
    }
    
    static func displayedWeight(for trip: Trip, in category: Category? = nil, weightType: WeightType = .totalWeight, unit: WeightUnit = .grams) -> String  {
        return display(weight(for: trip, in: category, weightType: weightType, units: unit), unit)
    }
    
    static func weight(for trip: Trip, in category: Category? = nil, weightType: WeightType = .totalWeight, units: WeightUnit = .grams) -> Double {
        
        var output = 0.0
        
        for packedItem in trip.packedItems {
            if let item = packedItem.item {
                if category == nil || item.category == category {
                    let itemWeight = WeightEngine.convertWeightUnit(item.weight, from: item.weightUnit, to: units) * Double(packedItem.quantity)
                    switch weightType {
                    case .totalWeight:
                        output += itemWeight
                    case .carriedWeight:
                        if !item.worn {output += itemWeight}
                    case .baseWeight:
                        if !item.worn && !item.consumable {output += itemWeight}
                    }
                }
            }
        }
        return output
    }
    
    static func chartableData(for trip: Trip, in categories: [Category], weightType: WeightType = .totalWeight) -> [ChartableCategory] {
        var output = [ChartableCategory]()
        for category in categories.sorted(by: {$0.id < $1.id}) {
//            var items = [ChartableItem]()
//            for packedItem in packedItems {
//                if let item = packedItem.item {
//                    if item.category == category {
//                        items.append(ChartableItem(name: item.name, quantity: packedItem.quantity, weight: item.weight))
//                    }
//                }
//            }
            let chartableCategory = ChartableCategory(
                id: category.id,
                name: category.name,
                icon: category.icon,
                color: category.colorComponents.color,
                weight: weight(for: trip, in: category, weightType: weightType, units: .grams))
            
            if chartableCategory.weight > 0 {
                output.append(chartableCategory)
            }
        }
        return output
    }
}
