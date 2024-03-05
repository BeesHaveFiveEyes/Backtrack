//
//  EmptyTripView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 28/11/2023.
//

import SwiftUI

struct EmptyTripView: View {
    
    var createNewItem: () -> () = {}
    var importItems: () -> () = {}
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                ActionableHeaderView(title: "Add Items")
                    .padding(.bottom, -14)
                Text("Start by importing items from your \(Image(systemName: "backpack")) Kit Library, or creating new items for this trip.")
                    .listRowInsets(EdgeInsets())
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(EmptyView())                
        } footer: {
            HStack(spacing: 14) {
                PanelButton(label: "Create New Item", icon: .systemName("plus"), action: createNewItem)
                    .contentShape(Rectangle())
                PanelButton(label: "Import Items", icon: .systemName("square.and.arrow.down"), action: importItems)
                    .contentShape(Rectangle())
            }
            .padding(.top, 28)
            .listRowInsets(EdgeInsets())
        }
        .padding(.bottom)
    }
}

#Preview {
    Form {
        EmptyTripView()
    }
}
