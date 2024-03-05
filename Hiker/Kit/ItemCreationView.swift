//
//  ItemCreationView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 12/12/2023.
//

import SwiftUI
import SwiftData

struct ItemCreationView: View {
    
    @Bindable var item: Item
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            ItemOptionsView(item: item)
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
                    item.temporary = false
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(item.name == "")
            }
        }
    }
}
