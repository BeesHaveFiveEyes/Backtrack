//
//  EditItemsView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 04/12/2023.
//

import SwiftUI
import SwiftData

struct EditPackedItemsView: View {
    
    @Bindable var trip: Trip
        
    @State private var selection = Set<PackedItem.ID>()
    @State private var editMode: EditMode = .active
    
    @State private var showingDeleteConfirmationDialogue = false
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @Query(sort: \Category.id) var categories: [Category]
    
    var body: some View {
        NavigationStack {
            List (selection: $selection) {
                ForEach (categories) { category in
                    if !trip.packedItems.filter({$0.item?.category == category}).isEmpty {
                        Section {
                            ForEach (trip.packedItems.filter({$0.item?.category == category}).sorted(by: {$0.categoryPosition < $1.categoryPosition})) { packedItem in
                                if let item = packedItem.item {
                                    ItemRowView(packedItem: packedItem, item: item)
                                }
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
            .navigationTitle("Edit Pack Contents")
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
                            selection = Set<PackedItem.ID>()
                            for packedItem in trip.packedItems {
                                selection.insert(packedItem.id)
                            }
                        }
                        else {
                            selection = Set<PackedItem.ID>()
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
            for packedItemID in selection {
                if let packedItem = trip.packedItems.first(where: {$0.id == packedItemID}) {
                    handleDeletion(packedItem)
                }
            }
            selection = Set<PackedItem.ID>()
            if trip.packedItems.isEmpty {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func handleDeletion(_ packedItem: PackedItem) {
        if let item = packedItem.item {
            if (item.isEmpty || !item.saved) && item.packedItemInstances.count < 2 {
                modelContext.delete(item)
            }
        }
        modelContext.delete(packedItem)
    }
    
    func moveSelectionToCategory(_ category: Category) {
        withAnimation {
            for packedItemID in selection {
                if let packedItem = trip.packedItems.first(where: {$0.id == packedItemID}) {
                    if let item = packedItem.item {
                        item.category = category
                    }
                }
            }
            selection = Set<PackedItem.ID>()
        }
    }
    
    func addCategoryToSelection(_ category: Category) {
        for packedItem in trip.packedItems {
            if let item = packedItem.item {
                if item.category == category {
                    selection.insert(packedItem.id)
                }
            }
        }
    }
}
