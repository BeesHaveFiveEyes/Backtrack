//
//  ItemEditingView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 12/12/2023.
//

import SwiftUI
import SwiftData

struct ItemEditingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Bindable var item: Item
    
    var body: some View {
        Form {
            ItemOptionsView(item: item)
        }
        .navigationTitle("Item")
        .navigationBarTitleDisplayMode(.inline)
    }
}
