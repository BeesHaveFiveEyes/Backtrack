//
//  PackedItemEditingView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 10/12/2023.
//

import SwiftUI
import SwiftData

struct PackedItemEditingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Bindable var packedItem: PackedItem
    
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
        .navigationTitle("Packed Item")
        .navigationBarTitleDisplayMode(.inline)
    }
}
