//
//  CategoryHeaderView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 22/10/2023.
//

import SwiftUI

struct CategoryHeaderView: View {
    
    var category: Category
    
    var editCategory: () -> () = {}
    var addItem: () -> () = {}
    
    var body: some View {
        HStack {
            Menu {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
                Button(action: editCategory) {
                    Label("Edit Category", systemImage: "folder.badge.gearshape")
                }
            } label: {
                HStack(spacing: 0) {
                    IconView(icon: category.icon, color: category.colorComponents.color)
                        .padding(.trailing, 10)
                    Text(category.name)
                        .font(.headline)
                        .padding(.trailing, 4)
                    Image(systemName: "chevron.down")
                        .font(.caption)
                }
                .foregroundStyle(category.colorComponents.color)
                
            }
            
            Spacer()
        }
        .padding(8)
        .padding(.vertical, 6)
        .textCase(.none)
        .listRowInsets(EdgeInsets())
    }
}
