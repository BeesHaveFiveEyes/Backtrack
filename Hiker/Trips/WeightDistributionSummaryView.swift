//
//  WeightDistributionSummaryView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 02/12/2023.
//

import SwiftUI

struct WeightDistributionSummaryView: View {
    
    var trip: Trip
    var categories: [Category]
    
    var data: [ChartableCategory] {
        WeightEngine.chartableData(for: trip, in: categories)
    }
    var body: some View {
        VStack {
            HStack {
                Text("\(data.count) Categories")
                Spacer()
                Text("\(trip.packedItems.count) Items")
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 4)
            WeightChartView(data: WeightEngine.chartableData(for: trip, in: categories), weightChartType: .linear)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .frame(height: 22)
            HStack{
                Spacer()
                categories.reduce(Text("")) {
                    if WeightEngine.weight(for: trip, in: $1) > 0 {
                        return $0 + Text("\(Image(systemName: "circlebadge.fill"))\u{00A0}").foregroundStyle($1.colorComponents.color)
                        + Text($1.name.replacingOccurrences(of: " ", with: "\u{00A0}"))//.foregroundStyle(.secondary)
                        + Text("   ")
                    }
                    else {
                        return $0
                    }
                }
                .lineLimit(3)
                Spacer()
            }
            .padding(.top, 7)
            .lineSpacing(4)
            .multilineTextAlignment(.center)
            .font(.caption2)
        }
    }
}
