//
//  WeightDistributionView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 28/11/2023.
//

import SwiftUI
import SwiftData

struct WeightDistributionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Bindable var trip: Trip
    @Query(sort: \Category.id) var categories: [Category]
    
    @State private var selections = [Category: Bool]()
    @State private var animators = [Category: Int]()
    @State private var selectedWeightType = WeightEngine.WeightType.totalWeight
    
    var selectedCategories: [Category] {
        return categories.filter({selections[$0] ?? false})
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ForEach(categories) { category in
                        if WeightEngine.weight(for: trip, in: category) > 0 {
                            Button {
                                withAnimation {
                                    selections[category] = !(selections[category] ?? false)
                                }
                                if selections[category] ?? false {
                                    animators[category]? += 1
                                }
                            } label: {
                                HStack {
                                    Image(systemName: (selections[category] ?? false) ? "checkmark.circle.fill" : "circle")
                                        .font(.title3)
                                        .foregroundStyle((selections[category] ?? false) ? category.colorComponents.color : .secondary)
                                        .symbolEffect(.bounce, options: .speed(2), value: animators[category])
                                    Text(category.name)
                                    Spacer()
                                    Text(WeightEngine.displayedWeight(for: trip, in: category, weightType: selectedWeightType, unit: trip.totalsWeightUnit))
                                }
                                .foregroundStyle((selections[category] ?? false) ? Color.primary : .secondary)
                            }
                        }
                    }
                } header: {
                    VStack {
                        Picker("Weight Mode", selection: $selectedWeightType) {
                            Text("Base Weight").tag(WeightEngine.WeightType.baseWeight)
                            Text("Carried Weight").tag(WeightEngine.WeightType.carriedWeight)
                            Text("Total Weight").tag(WeightEngine.WeightType.totalWeight)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom)
                        
                        WeightChartView(data:
                            WeightEngine.chartableData(for: trip, in: selectedCategories, weightType: selectedWeightType),
                            weightChartType: .radial
                        )
                        .frame(height: 350)
                    }
                    .padding(.bottom, 30)
                    .textCase(.none)
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationTitle("Weight Distribution")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            for category in categories {
                selections[category] = true
                animators[category] = 0
            }
        }
    }
}
