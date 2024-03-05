//
//  ItemsListView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 22/11/2023.
//

import SwiftUI

struct ItemsListView: View {
    var body: some View {
        ForEach (categories.sorted(by: {$0.id < $1.id})) { category in
            if !trip.items.filter({$0.category == category}).isEmpty {
                Section {
                    ForEach (trip.items) { item in
                        if item.category == (category as Category?) {
                            ItemRowView(item: item)
                            .background{
                                NavigationLink("", value: item).opacity(0)
                            }
                        }
                    }
                    HStack {
                        Text("Total")
                        Spacer()
                        Text("200g")
                    }
                    .fontWeight(.bold)
                } header: {
                    CategoryHeaderView(
                        category: category,
                        editCategory: {editingCategory = category},
                        addItem: {addItem(to: category)}
                    )
                }
            }
        }
        
        if trip.items.filter({$0.category == nil}).count > 0 {
            Section {
                ForEach (trip.items) { item in
                    if item.category == nil {
                        NavigationLink(value: item) {
                            ItemRowView(item: item)
                        }
                    }
                }
            } header: {
                HStack {
                    Text("Uncategorised")
                    Spacer()
                    Text("200 g")
                }
            }
        }
    }
}

#Preview {
    ItemsListView()
}
