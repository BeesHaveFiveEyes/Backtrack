//
//  DonutChartView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 24/11/2023.
//

import SwiftUI
import Charts

struct ChartableCategory {
    var id: Int
    var name: String
    var icon: Icon
    var color: Color
    var weight: Double
    var weightUnit: WeightUnit
    
    init(id: Int, name: String, icon: Icon, color: Color, weight: Double, weightUnit: WeightUnit = .grams) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
        self.weight = weight
        self.weightUnit = weightUnit
    }
}

struct WeightChartView: View {
    
    enum WeightChartType {
        case linear
        case radial
    }
    
    var data: [ChartableCategory]
    var weightChartType: WeightChartType
    var weightUnit = WeightUnit.grams
    
    @State private var selectedWeight: Double? = nil
    
    var colorMapping: [Color] {
        var output = [Color]()
        for category in data {
            output.append(category.color)
        }
        return output
    }
    
    var totalWeight: Double {
        var output = 0.0
        for category in data {
            output += category.weight
        }
        return output
    }
    
    var body: some View {
        GeometryReader { proxy in
            Chart(data, id: \.id) { category in
                if weightChartType == .linear {
                    BarMark(
                        x: .value("Weight", category.weight),
                        stacking: .normalized
                    )                    
                    .foregroundStyle(by: .value("Type", category.name))
                    .opacity(selectedCategory != nil && selectedCategory?.id != category.id ? 0.2 : 1)
                    .annotation(position: .overlay, alignment: .center) {
//                        if category.weight > 0 {
//                            ViewThatFits {
////                                HStack {
////                                    IconView(icon: category.icon, color: .white, font: .caption)
////                                    Text("\(category.weight, format: .number.precision(.fractionLength(0))) g")
////                                        .fixedSize(horizontal: true, vertical: false)
////                                        .font(.caption.weight(.bold))
////                                        .foregroundColor(.white)
////                                }
////                                .fixedSize(horizontal: true, vertical: false)
//                                
//                                IconView(icon: category.icon, color: .white, font: .caption)
//                                    .symbolVariant(.fill)
//                                
//                                Text("")
//                            }                            
//                            .frame(width: proxy.size.width * CGFloat(category.weight) / CGFloat(totalWeight))
//                        }
                    }
                }
                else {
                    SectorMark(
                        angle: .value("Count", category.weight),
                        innerRadius: .ratio(selectedCategory?.id == category.id ? 0.55 : 0.6),
                        outerRadius: .ratio(selectedCategory?.id == category.id ? 1 : 0.95)
//                        angularInset: 5.0
                    )
//                    .cornerRadius(5)
                    .foregroundStyle(by: .value("Type", category.name))
                    .opacity(selectedCategory != nil && selectedCategory?.id != category.id ? 0.8 : 1)
                    .annotation(position: .overlay) {
                        if category.weight / totalWeight > 0.03 {
                            IconView(icon: category.icon, color: .white, font: .caption)
                                .symbolVariant(.fill)
                        }
                    }
                }
            }
            .overlay { //_ in
                if weightChartType == .radial {
                    VStack {
                        if let category = selectedCategory {
                            Text(category.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(category.color)
                            Text(WeightEngine.display(category.weight, weightUnit))
                        }
                    }
                    .background {
                        Circle()
                            .foregroundStyle(Color(.panel))
                            .frame(width: proxy.size.width * 0.6, height:  proxy.size.width * 0.6)
                    }
                }
            }
            .chartXAxis(.hidden)
            .chartAngleSelection(value: $selectedWeight)
            .chartForegroundStyleScale(range: colorMapping)
            .chartLegend(.hidden)
            .chartLegend(alignment: .center)
        }        
//        .listRowBackground(EmptyView())
    }
    
    var selectedCategory: ChartableCategory? {
        if let w = selectedWeight {
            var accumulatedWeight = 0.0
            let category = data.first {
                accumulatedWeight += $0.weight
                return w <= accumulatedWeight
            }
            return category
        }
        return nil
    }
}

#Preview {
    
    WeightChartView(data: [
        ChartableCategory(
            id: 0,
            name: "Food",
            icon: .systemName("fork.knife"),
            color: .cerise,
            weight: 723
        ),
        
        ChartableCategory(
            id: 1,
            name: "Water",
            icon: .systemName("drop"),
            color: .teal,
            weight: 1000
        ),
        
        ChartableCategory(
            id: 2,
            name: "Clothing",
            icon: .systemName("tshirt"),
            color: .orange,
            weight: 940
        ),
        
        ChartableCategory(
            id: 3,
            name: "Other",
            icon: .systemName("folder"),
            color: .blue,
            weight: 330
        ),
    ],
    weightChartType: .radial)
}
