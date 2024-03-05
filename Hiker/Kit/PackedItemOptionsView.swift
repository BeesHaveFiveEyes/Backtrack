//
//  PackedItemView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 24/11/2023.
//

import SwiftUI
import SwiftData

struct PackedItemOptionsView: View {
    
    @Bindable var packedItem: PackedItem
    @State private var starAnimator = 0
    
    var body: some View {
        Section {
            
            HStack {
                Text("Quantity")
                Spacer()
                Text("\(packedItem.quantity)")
                    .foregroundStyle(.secondary)
                Stepper("Quantity", value: $packedItem.quantity)
                    .labelsHidden()
            }
            .icon(systemName: "doc.on.doc")
        }
        .toolbar {
            ToolbarItem {
                Button {
                    packedItem.starred.toggle()
                    if packedItem.starred {
                        starAnimator += 1
                    }
                } label: {
                    Image(systemName: "star")
                        .symbolVariant(packedItem.starred ? .fill : .none)
                        .symbolEffect(.bounce, options: .speed(1.5), value: starAnimator)
                }
            }
        }
    }
}

