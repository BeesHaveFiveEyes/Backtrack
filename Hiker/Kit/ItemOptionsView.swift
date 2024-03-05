//
//  ItemView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 04/10/2023.
//

import SwiftUI
import SwiftData

struct ItemOptionsView: View {
    
    @Bindable var item: Item
    
    @Query var categories: [Category]
    
    var body: some View {
        
        Group {
            TextField("Item name...", text: $item.name)
            .icon(systemName: "pencil.line")
            
            Section {
                HStack {
                    Text("Weight")
                    Spacer()
                    TextField("...", value: $item.weight, format: .number)
                        .frame(maxWidth: 40)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background{
                            RoundedRectangle(cornerRadius: 7)
                                .foregroundStyle(.backing)
                        }
                    Picker("Units", selection: $item.weightUnit) {
                        Text("g").tag(WeightUnit.grams)
                        Text("kg").tag(WeightUnit.kilograms)
                        Text("oz").tag(WeightUnit.ounces)
                        Text("lb").tag(WeightUnit.pounds)
                    }
                    .labelsHidden()
                    
                }
                .icon(.systemName("scalemass"))
            }

            Section {
                Picker("Category", selection: $item.category) {
                    ForEach(categories.sorted(by: {$0.id < $1.id})) { category in
                        Text(category.name).tag(category as Category?)
                    }
                }
                .icon(systemName: "folder")
            }
            Section {
                Toggle("Consumable", isOn: $item.consumable)
                    .icon(systemName: "fork.knife")
                Toggle("Worn", isOn: $item.worn)
                    .icon(systemName: "tshirt")
            } footer: {
                Text("Consumable and worn items are not included in the base weight calculation.")
            }

            Section {
                Picker("Condition", selection: $item.condition) {
                    Text("Perfect").tag("Perfect")
                    Text("Good").tag("Good")
                    Text("Acceptable").tag("Acceptable")
                    Text("Poor").tag("Poor")
                    Text("None").tag("")
                }
                .icon(systemName: "sparkles")
                HStack {
                    Text("Brand")
                    Spacer()
                    TextField("none", text: $item.brand)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(.secondary)
                }
                .icon(systemName: "bag")
                HStack {
                    Text("Price")
                    Spacer()
                    TextField("none", text: $item.brand)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(.secondary)
                }
                .icon(systemName: "banknote")
            }

            Section(header: Text("Kit Library"), footer: Text("Save this item to your Kit List to reuse it on future trips.")) {
                Toggle("Save to Kit Library", isOn: $item.saved)
                    .icon(systemName: "backpack")
            }
            
            Section(header: Text("Notes")) {
                TextField("Enter notes...", text: $item.notes, axis: .vertical)
            }
        }
    }
}
