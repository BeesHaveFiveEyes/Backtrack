//
//  KitView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 18/10/2023.
//

import SwiftUI
import SwiftData
import TipKit

struct KitView: View {
    
    enum SortMode {
        case name
        case weight
    }
    
    @Query private var items: [Item]
    @Query(sort: \Category.id) var categories: [Category]   
    
    @Environment(\.modelContext) var modelContext
    
    @State private var navigationPath = NavigationPath()
    
    @State private var showingEditCategoriesView = false
    @State private var showingEditItemsView = false
    @State private var editingCategory: Category? = nil
    
    private let kitLibraryTip = KitLibraryTip()
    
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State private var selectedSortMode = SortMode.name
    
    @State private var newItem: Item? = nil
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                
                if !searchIsActive {
                    Section {
                        TipView(kitLibraryTip)
                            .tipBackground(.panel)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(EmptyView())
    //                    DetailPair(description: "Total Items", detail: "\(items.filter({!$0.temporary}).count)")
                    }
                }
                
                ForEach (categories) { category in
                    Section {
                        ForEach (items.sorted(by: sorting).filter({!$0.temporary})) { item in
                            if item.category == (category as Category?) && (searchText == "" || item.name.contains(searchText)) {
                                ItemRowView(item: item)
                                .background{
                                    NavigationLink("", value: item).opacity(0)
                                }
                            }
                        }
                        if items.filter({ $0.category == category }).count == 0 {
                            Text("No items")
                                .foregroundStyle(.secondary)
                        }
                    } header: {
                        CategoryHeaderView(
                            category: category,
                            editCategory: {editingCategory = category},
                            addItem: {addItem(to: category)}
                        )
                    }
                }
                
                if items.filter({ $0.category == nil }).count > 0 {
                    ForEach (items) { item in
                        if item.category == nil {
                            ItemRowView(item: item)
                            .background{
                                NavigationLink("", value: item).opacity(0)
                            }
                        }
                    }
                }
                
            }
            .navigationDestination(for: Item.self) { item in
                return ItemEditingView(item: item)
            }
            .navigationTitle("Kit Library")
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button(action: {showingEditCategoriesView = true})  {
                            Label("Configure Categories", systemImage: "folder.badge.gearshape")
                        }
                        Button(action: {showingEditItemsView = true}) {
                            Label("Edit Kit Library", systemImage: "checklist")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                ToolbarItem {
                    Button(action: prepareNewItemSheet) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Sorting", selection: $selectedSortMode) {
                            Label("Alphabetical", systemImage: "textformat").tag(SortMode.name)
                            Label("By Weight", systemImage: "scalemass").tag(SortMode.weight)
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }
                }
            }
        }
        .searchable(text: $searchText, isPresented: $searchIsActive, prompt: "Search for an item...")
        .sheet(item: $newItem, onDismiss: deleteTemporaryItems) { item in
            NavigationStack {
                ItemCreationView(item: item)
            }
        }
        .sheet(item: $editingCategory) { category in
            NavigationStack {
                CategoryView(category: category)
            }
        }
        .sheet(isPresented: $showingEditCategoriesView) {
            NavigationStack {
                EditCategoriesView()
            }
        }
        .sheet(isPresented: $showingEditItemsView) {
            EditItemsView()
        }
        .onAppear(perform: deleteTemporaryItems)
    }
    
    func prepareNewItemSheet() {
        
        // Create Item
        let item = Item(name: "", category: nil, weight: 0)
        item.category = categories.first
        item.temporary = true
        
        Task {
            try await Task.sleep(nanoseconds: 10000000)
            newItem = item
        }
    }
    
    func sorting(_ lhs: Item, _ rhs: Item) -> Bool {
        switch selectedSortMode {
        case .name:
            return lhs.name < rhs.name
        case .weight:
            return lhs.weight < rhs.weight
        }
    }
    
    func addItem(to category: Category) {
        let item = Item(name: "", category: nil, weight: 100)
        modelContext.insert(item)
        navigationPath.append(item)
    }
    
    func deleteTemporaryItems() {
        for item in items {
            if item.temporary && item.packedItemInstances.count < 2 {
                modelContext.delete(item)
            }
        }
    }
}
