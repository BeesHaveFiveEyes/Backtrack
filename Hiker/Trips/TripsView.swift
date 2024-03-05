//
//  TripsView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 04/10/2023.
//

import SwiftUI
import SwiftData
import TipKit

struct TripsView: View {
    
    var showSettingsSheet = {}
    
    @Environment(\.modelContext) var modelContext
    @Query var trips: [Trip]
    
    @State private var navigationPath = NavigationPath()
    @State private var showingNewTripSheet = false
    @State private var newTrip: Trip? = nil        
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                if trips.isEmpty {
                    Form {
                        ContentUnavailableView {
                            Label("No Trips Created", systemImage: "mountain.2")
                        } description: {
                            Text("Tap the \(Image(systemName: "plus")) button to add new trip.")
                        }
                    }
                }
                else {
                    List {
                        ForEach(trips) { trip in
                            NavigationLink(value: trip) {
                                VStack(alignment: .leading) {
                                    Text(trip.displayName)
                                    Text(trip.displayCaption)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                .icon(trip.icon, font: .largeTitle)
                            }
                        }
                        .onDelete(perform: deleteTrips)
                    }
                }
            }
            .navigationTitle("My Trips")
            .navigationDestination(for: Trip.self) { trip in
                TripView(trip: trip, navigationPath: $navigationPath)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: showSettingsSheet) {
                        Image(systemName: "gear")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        newTrip = Trip(icon: .text("\u{26F0}"))
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $newTrip) { trip in
                TripDetailsView(trip: trip, newTrip: true, onSubmit: insertNewTrip)
            }
            .onAppear(perform: removeTemporaryPackedItems)
        }
    }
    
    func insertNewTrip(trip: Trip) {
        modelContext.insert(trip)
    }
    
    func deleteTrips(_ indexSet: IndexSet) {
        for index in indexSet {
            let trip = trips[index]
            modelContext.delete(trip)
        }
    }
    
    func removeTemporaryPackedItems() {
        for trip in trips {
            for packedItem in trip.packedItems {
                if packedItem.temporary {
                    if let item = packedItem.item {
                        if item.packedItemInstances.count == 1 {
                            modelContext.delete(item)
                        }
                    }
                    modelContext.delete(packedItem)
                }
            }
        }
    }
}

#Preview {
    TripsView()
}
