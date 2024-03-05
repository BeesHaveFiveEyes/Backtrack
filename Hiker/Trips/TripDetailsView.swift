//
//  TripDetailsView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 27/11/2023.
//

import SwiftUI

struct TripDetailsView: View {
        
    @Bindable var trip: Trip
    
    var newTrip = false
    var onSubmit: (Trip) -> () = {_ in}
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("none", text: $trip.name)
                        .multilineTextAlignment(.trailing)
                }
                .icon(systemName: "pencil.line")
                
                IconPickerView(selectedIcon: $trip.icon, iconSets: [.recommendedEmoji, .flags])
                
                Section {
                    HStack {
                        Text("Location")
                        Spacer()
                        TextField("none", text: $trip.locationDescription)
                            .multilineTextAlignment(.trailing)
                    }
                    .icon(.systemName("mappin.and.ellipse"))
                    
                    DistancePicker(text: "Distance", distance: $trip.distance, unit: $trip.distanceUnit)
                        .icon(.systemName("figure.hiking"))
                }
                
                Section {
                    DatePicker("Start Date", selection: $trip.startDate, displayedComponents: .date)
                    .icon(systemName: "calendar")
                    
                    DatePicker("End Date", selection: $trip.endDate, displayedComponents: .date)
                    .icon(systemName: "calendar")
                }
            }
            .navigationTitle(newTrip ? "New Trip" : "Trip Details")
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        onSubmit(trip)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(newTrip && trip.name == "")
                }
                
                if (newTrip) {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}
