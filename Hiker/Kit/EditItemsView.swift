//
//  EditItemsView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 12/12/2023.
//

import SwiftUI
import SwiftData

struct EditItemsView: View {
        
    @State private var selection = Set<Item.ID>()
    @State private var editMode: EditMode = .active
    
    @State private var showingDeleteConfirmationDialogue = false
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @Query(filter: #Predicate<Item> { item in
        item.saved
    }, sort: \Item.name) var items: [Item]
    
    @Query(sort: \Category.id) var categories: [Category]
    
    var body: some View {
        NavigationStack {
            List (selection: $selection) {
                ForEach (categories) { category in
                    if !items.filter({$0.category == category}).isEmpty {
                        Section {
                            ForEach (items.filter({$0.category == category})) { item in
                                ItemRowView(item: item)
                            }
                        } header: {
                            Text(category.name).icon(category.icon, color: .secondary, font: .caption)
                        }
                    }
                }
            }
            .confirmationDialog(Text("Delete \(selection.count) Items?"), isPresented: $showingDeleteConfirmationDialogue, titleVisibility: .visible, actions: {
                Button("Delete", role: .destructive, action: deleteSelection)
            })
            .environment(\.editMode, $editMode)
            .navigationTitle("Edit Kit Library")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(selection.count > 0 ? "Deselect" : "Select All") {
                        if selection.count == 0 {
                            selection = Set<Item.ID>()
                            for item in items {
                                selection.insert(item.id)
                            }
                        }
                        else {
                            selection = Set<Item.ID>()
                        }
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Menu {
//                        Button {
//
//                        } label: {
//                            Label("Star", systemImage: "star")
//                        }
//                        Button {
//
//                        } label: {
//                            Label("Worn", systemImage: "tshirt")
//                        }
//                        Button {
//
//                        } label: {
//                            Label("Consumable", systemImage: "fork.knife")
//                        }
                        Menu {
                            ForEach(categories) { category in
                                Button {
                                    moveSelectionToCategory(category)
                                } label: {
                                    Text(category.name)
                                }
                            }
                        } label: {
                            Label(selection.count > 1 ? "Move Items" : "Move Item", systemImage: "folder")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                    .disabled(selection.count == 0)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingDeleteConfirmationDialogue = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .disabled(selection.count == 0)
                }
            }
        }
    }
    
    func deleteSelection() {
        withAnimation {
            for itemID in selection {
                if let item = items.first(where: {$0.id == itemID}) {
                    handleDeletion(item)
                }
            }
            selection = Set<Item.ID>()
            if items.isEmpty {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func handleDeletion(_ item: Item) {
        if item.packedItemInstances.count == 0 {
            modelContext.delete(item)
        }
        else {
            item.saved = false
        }
    }
    
    func moveSelectionToCategory(_ category: Category) {
        withAnimation {
            for itemID in selection {
                if let item = items.first(where: {$0.id == itemID}) {
                    item.category = category
                }
            }
            selection = Set<PackedItem.ID>()
        }
    }
    
    func addCategoryToSelection(_ category: Category) {
        for item in items {
            if item.category == category {
                selection.insert(item.id)
            }
        }
    }
}
