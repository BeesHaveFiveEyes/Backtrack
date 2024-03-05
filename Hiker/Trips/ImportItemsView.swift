//
//  ImportItemsView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 23/10/2023.
//

import SwiftUI
import SwiftData

struct ImportItemsView: View {
    
    @Bindable var trip: Trip
    
    @Query var allItems: [Item]

    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    var allSelected: Bool {
        for item in allItems {
            if !trip.packedItems.contains(where: {$0.item == item}) {
                return false
            }
        }
        return true
    }
    
    var body: some View {
        NavigationStack {
            List(allItems) { item in
                Button {
                    if tripContains(item) {
                        setItemSelection(of: item, to: false)
                    }
                    else {
                        setItemSelection(of: item, to: true)
                    }
                } label: {
                    ItemRowView(item: item)
                        .icon(.systemName(tripContains(item) ? "checkmark" : ""), color: .accentColor)
                        .foregroundStyle(.foreground)
                }
            }
            .navigationTitle("Import Items")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button("Done") {presentationMode.wrappedValue.dismiss()}
                }
                ToolbarItem(placement: .cancellationAction){
                    Button(allSelected ? "Deselect All" : "Select All") {
                        setItemSelection(of: allItems, to: !allSelected)
                    }
                }
            }
        }
    }
    
    func setItemSelection(of item: Item, to value: Bool) {
        if value == true {
            if trip.packedItems.firstIndex(where: {$0.item == item}) == nil {
                
                // Create a new packed item
                
                let j = trip.packedItems.filter({$0.item?.category == item.category}).count
                let packedItem = PackedItem(categoryPosition: j)
                trip.packedItems.append(packedItem)
                packedItem.item = item
            }
        }
        else {
            if let i = trip.packedItems.firstIndex(where: {$0.item == item}) {
                
                // Handle packed item deletion
                
                let packedItem = trip.packedItems[i]
                                
                if let item = packedItem.item {
                    
                    // Handle potential item deletion
                    
                    if item.packedItemInstances.count == 1 && !item.saved {
                        packedItem.item = nil
                        modelContext.delete(item)
                    }
                }
                
                trip.packedItems.remove(at: i)
            }
        }
    }
    
    func setItemSelection(of items: [Item], to value: Bool) {
        for item in items {
            setItemSelection(of: item, to: value)
        }
    }
    
    func tripContains(_ item: Item) -> Bool {
        return trip.packedItems.contains(where: {$0.item == item})
    }
}
