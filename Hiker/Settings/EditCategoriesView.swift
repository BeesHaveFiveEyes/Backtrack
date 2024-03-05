//
//  EditCategoriesView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 22/10/2023.
//

import SwiftUI
import SwiftData

struct EditCategoriesView: View {
    
    @Query var categories: [Category]
    
    var body: some View {
        Form {
            ForEach(categories.sorted(by: {$0.id < $1.id})) { category in
                NavigationLink(value: category) {
                    Text(category.name)
                        .icon(category.icon, color: category.colorComponents.color)
                }
            }
        }
        .navigationDestination(for: Category.self) { category in
            return CategoryView(category: category)
        }
        .navigationTitle("Categories")
    }
}

#Preview {
    EditCategoriesView()
}
