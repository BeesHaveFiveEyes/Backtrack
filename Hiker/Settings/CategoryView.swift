//
//  CategoryView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 22/10/2023.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    
    @Bindable var category: Category
    @State private var localColor: Color = .teal
    
    @Environment(\.presentationMode) var presentationMode
    
    var itemDefaultsFooterText: String {
        let intro = "New items added to this category will be marked as "
        if category.worn && category.consumable {
            return intro + " both worn and consumable by default."
        }
        else if category.worn {
            return intro + " worn by default."
        }
        else if category.worn {
            return intro + " consumable by default."
        }
        else {
            return intro + " neither worn nor consumable by default."
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Category name...", text: $category.name)
            } header: {
                Text("Category Name")
            }
            Section {
                IconPickerView(selectedIcon: $category.icon, iconSets: [.categories])
                ColorPicker("Color", selection: $localColor)
            } header: {
                Text("Appearance")
            }
            
            Section {
                Toggle("Worn", isOn: $category.worn)
                Toggle("Consumable", isOn: $category.consumable)
            } header: {
                Text("Item Defaults")
            } footer: {
                Text(itemDefaultsFooterText)
            }
        }
        .onChange(of: localColor) {
            category.colorComponents = .fromColor(localColor)
        }
        .task {
            localColor = category.colorComponents.color
        }
        .navigationTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Done") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Category.self, configurations: config)
        let example = Category(id: 0, name: "Navigation", icon: .systemName("map"))
        return NavigationStack {
            CategoryView(category: example)
        }
    .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
