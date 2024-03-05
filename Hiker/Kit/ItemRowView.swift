//
//  ItemRowView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 22/10/2023.
//

import SwiftUI

struct ItemRowView: View {
    
    var packedItem: PackedItem?
    var item: Item
    
    var body: some View {
        HStack {
            if let quantity = packedItem?.quantity {
                if quantity > 1 {
                    HStack (spacing: 4){
                        Text("\(quantity)")
                        Image(systemName: "multiply")
                            .foregroundStyle(item.category?.colorComponents.color ?? .primary)
                    }
                }
            }
            if item.name.count > 0 {
                Text(item.name)
            }
            else {
                Text("Unnamed Item")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            HStack {
                if item.consumable {
                    Image(systemName: "fork.knife")                        
                }
                if item.worn {
                    Image(systemName: "tshirt")
                }
                if packedItem?.starred ?? false {
                    Image(systemName: "star")
                }
            }
            .foregroundStyle(.secondary)
            Text(item.displayWeight)
                .frame(width: 60, alignment: .trailing)
        }
    }
}
