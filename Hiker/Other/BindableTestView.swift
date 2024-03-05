//
//  BindableTestView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 10/12/2023.
//

import SwiftData
import SwiftUI

struct BindableTestView: View {
    
    @Query var trips: [Trip]
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(trips) { trip in
                    NavigationLink {
                        BindableTestTripView(trip: trip)
                    } label: {
                        Text(trip.name)
                    }
                }
            }
        }
    }
}

struct BindableTestTripView: View {

    @Bindable var trip: Trip
    
    var body: some View {
        Form {
            Text(trip.name)
            BindableTestTripDetailView(trip: trip)
        }
    }
}

struct BindableTestTripDetailView: View {

    @Bindable var trip: Trip
    
    var body: some View {
        TextField("Name", text: $trip.name)
    }
}
