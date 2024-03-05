//
//  TripView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 04/10/2023.
//

import SwiftUI
import SwiftData

struct TripView: View {
    
    @Bindable var trip: Trip
    @Binding var navigationPath: NavigationPath
    
    @State private var showingImportItemsSheet = false
    @State private var showingTripDetailsSheet = false
    @State private var showingTripOptionsSheet = false
    @State private var showingAddItemConfirmationDialogue = false
    @State private var showingEditItemsSheet = false
    @State private var showingWeightDistributionSheet = false
    
    @State private var editingCategory: Category? = nil
    @State private var newPackedItem: PackedItem? = nil
    
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Category.id) var categories: [Category]
    
    var body: some View {
        Form {
            TripHeaderView(trip: trip)
            
            
//            NavigationLink {
//                RoutePlanView(trip: trip)
//            } label: {
//                Text("Route Plan")
//            }
            
            Section {
//                TripHeaderView(trip: trip)
                MapView()
                    .listRowInsets(EdgeInsets())
                    .frame(height: 150)
            } header: {
//                ActionableHeaderView(title: "Route", action: {}, actionTitle: "View")
            }
            .listSectionSpacing(7)
            
            if trip.packedItems.filter({!$0.temporary}).count > 0 {
                if WeightEngine.weight(for: trip) > 0 {
                    Section {
                        WeightDistributionSummaryView(trip: trip, categories: categories)
                        .onTapGesture {
                            showingWeightDistributionSheet = true
                        }
                    } header: {
                        ActionableHeaderView(title: "Weight Distribution", action: {showingWeightDistributionSheet = true}, actionTitle: "View")
                    }
                    .listSectionSpacing(14)                
                    
                    Section {
                        HStack {
                            Text("Base Weight")
                            Spacer()
                            Text(WeightEngine.displayedWeight(for: trip, weightType: .baseWeight, unit: trip.totalsWeightUnit))
                        }
                        HStack {
                            Text("Carried Weight")
                            Spacer()
                            Text(WeightEngine.displayedWeight(for: trip, weightType: .carriedWeight, unit: trip.totalsWeightUnit))
                        }
                        HStack {
                            Text("Total Weight")
                            Spacer()
                            Text(WeightEngine.displayedWeight(for: trip, weightType: .totalWeight, unit: trip.totalsWeightUnit))
                        }
                    }
                }
                
                Section {
                    ActionableHeaderView(title: "Pack Contents", action: { showingEditItemsSheet = true }, actionTitle: "Edit")
                        .listRowBackground(EmptyView())
                }
                .listSectionSpacing(10)
                
                ForEach (categories) { category in
                    if !trip.packedItems.filter({$0.item?.category == category}).isEmpty {
                        Section {
                            ForEach (trip.packedItems.filter({$0.item?.category == category}).sorted(by: {$0.categoryPosition < $1.categoryPosition})) { packedItem in
                                if !packedItem.temporary, let item = packedItem.item {
                                    HStack {
    //                                    Text("\(packedItem.categoryPosition)")
                                        ItemRowView(packedItem: packedItem, item: item)
                                    }
                                    .background{
                                        NavigationLink("", value: packedItem).opacity(0)
                                    }
                                }
                            }
                            .onMove {
                                move(from: $0, to: $1, in: category)
                            }
                            .onDelete {
                                deleteItems(at: $0, from: category)
                            }
                            
                            HStack {
                                Text("Total")
                                Spacer()
                                Text(WeightEngine.displayedWeight(for: trip, in: category, unit: trip.totalsWeightUnit))
                            }
                            .fontWeight(.bold)
                        } header: {
                            CategoryHeaderView(
                                category: category,
                                editCategory: {editingCategory = category},
                                addItem: {createNewItem(in: category)}
                            )
                        }
                    }
                }
            }
            else {
                EmptyTripView(createNewItem: prepareNewItemSheet, importItems: {showingImportItemsSheet = true})
            }
        }
        .navigationDestination(for: PackedItem.self) { packedItem in
            return PackedItemEditingView(packedItem: packedItem)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Menu {
                    Button(action: { showingTripDetailsSheet = true }) {
                        Label("Edit Trip Details", systemImage: "square.and.pencil")
                    }
                    Button(action: { showingTripOptionsSheet = true }) {
                        Label("Configure Units", systemImage: "scalemass")
                    }
                    Button(action: { showingEditItemsSheet = true }) {
                        Label("Edit Pack Contents", systemImage: "checklist")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
            ToolbarItem {
                Button(action: {showingAddItemConfirmationDialogue = true}) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(item: $newPackedItem, onDismiss: deleteTemporaryItems) { packedItem in
            NavigationStack {
                PackedItemCreationView(packedItem: packedItem)
            }
        }
        .sheet(isPresented: $showingImportItemsSheet) {
            ImportItemsView(trip: trip)
        }
        .sheet(isPresented: $showingTripDetailsSheet) {
            TripDetailsView(trip: trip)
        }
        .sheet(isPresented: $showingTripOptionsSheet) {
            TripOptionsView(trip: trip)
        }
        .sheet(item: $editingCategory) { category in
            NavigationStack {
                CategoryView(category: category)
            }
        }
        .sheet(isPresented: $showingWeightDistributionSheet) {
            WeightDistributionView(trip: trip)
        }
        .sheet(isPresented: $showingEditItemsSheet) {
            EditPackedItemsView(trip: trip)
        }
        .confirmationDialog("Add Item", isPresented: $showingAddItemConfirmationDialogue) {
            Button(action: prepareNewItemSheet) {
                Label("Add New Item", systemImage: "plus")
            }
            Button(action: { showingImportItemsSheet = true }) {
                Label("Import Existing Items", systemImage: "square.and.arrow.down")
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int, in category: Category) {
        
        var items = trip.packedItems.filter({$0.item?.category == category}).sorted(by: {$0.categoryPosition < $1.categoryPosition})
        
        var itemsToMove = [PackedItem]()
        for i in source {
            itemsToMove.append(items[i])
        }
        
        items.remove(atOffsets: source)
        let itemsToPreserve = items
        
        var j = 0
        var moved = false
        
        for itemToPreserve in itemsToPreserve {
            if j == destination {
                for itemToMove in itemsToMove {
                    itemToMove.categoryPosition = j
                    j += 1
                }
                moved = true
            }
            itemToPreserve.categoryPosition = j
            j += 1
        }
        
        if !moved {
            for itemToMove in itemsToMove {
                itemToMove.categoryPosition = j
                j += 1
            }
        }
    }
    
    func deleteItems(at indexSet: IndexSet, from category: Category) {
        let categoryItems = trip.packedItems.filter({$0.item?.category == category}).sorted(by: {$0.categoryPosition < $1.categoryPosition})
        for index in indexSet {
            let packedItem = categoryItems[index]
            handleDeletion(packedItem)
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
    
    func prepareNewItemSheet() {
        
        // Create Item
        
        let item = Item(name: "", category: nil, weight: 0)
        item.category = categories.first
        item.temporary = true
        
        // Create packed item
        
        let packedItem = PackedItem(categoryPosition: 0)
        packedItem.temporary = true
        trip.packedItems.append(packedItem)
        
        // Link the item and packed item
        
        item.packedItemInstances.append(packedItem)
        
        // Show sheet
                        
        Task {
            try await Task.sleep(nanoseconds: 10000000)
            newPackedItem = packedItem
        }
    }
    
    func createNewItem(in category: Category?) {
        
        // Create Item
        
        let item = Item(name: "", category: nil, weight: 0)
        if category == nil {
            item.category = categories.first
        }
        else {
            item.category = category
        }
        
        // Create packed item
        
        let packedItem = PackedItem(categoryPosition: trip.packedItems.filter({$0.item?.category == category}).count)
        
        // Add packed item to trip
        
        trip.packedItems.append(packedItem)
        
        // Link the item and packed item
        
        item.packedItemInstances.append(packedItem)
        
        // Navigate to packed item view
        
        navigationPath.append(packedItem)
    }  
    
    func deleteTemporaryItems() {
        for packedItem in trip.packedItems {
            if packedItem.temporary {
                if let item = packedItem.item {
                    modelContext.delete(item)
                }
                modelContext.delete(packedItem)
            }
        }
    }
}

struct DetailPair: View {
    var description: String
    var detail: String
    
    var body: some View {
        HStack {
            Text(description)
            Spacer()
            Text(detail)
                .foregroundStyle(.secondary)
        }
    }
}
