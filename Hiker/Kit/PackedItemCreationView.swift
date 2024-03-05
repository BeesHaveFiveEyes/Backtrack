//
//  PackedItemCreationView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 10/12/2023.
//

import SwiftUI
import SwiftData

struct PackedItemCreationView: View {
    
    @Bindable var packedItem: PackedItem
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            if let item = packedItem.item {
                ItemOptionsView(item: item)
            }
            else {
                Text("Missing Item")
            }
            PackedItemOptionsView(packedItem: packedItem)
        }
        .navigationTitle("New Item")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                    packedItem.temporary = false
                    packedItem.item?.temporary = false
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(packedItem.item?.name == "")
            }
        }
    }
}
