//
//  TripOptionsView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 28/11/2023.
//

import SwiftUI

struct TripOptionsView: View {
    
    @Bindable var trip: Trip
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Items Unit", selection: $trip.itemsWeightUnit) {
                    Text("Grams (g)").tag(WeightUnit.grams)
                    Text("Kilograms (kg)").tag(WeightUnit.kilograms)
                    Text("Ounces (oz)").tag(WeightUnit.ounces)
                    Text("Pounds (lb)").tag(WeightUnit.pounds)
                }
                
                Picker("Totals Unit", selection: $trip.totalsWeightUnit) {
                    Text("Grams (g)").tag(WeightUnit.grams)
                    Text("Kilograms (kg)").tag(WeightUnit.kilograms)
                    Text("Ounces (oz)").tag(WeightUnit.ounces)
                    Text("Pounds (lb)").tag(WeightUnit.pounds)
                }
            }
            .navigationTitle("Trip Options")
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
