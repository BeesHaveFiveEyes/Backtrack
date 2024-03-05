//
//  TripHeaderView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 21/11/2023.
//

import SwiftUI

struct TripHeaderView: View {
    
    var trip: Trip
    
    var body: some View {
        Section {
            HStack {
                Spacer()
                ViewThatFits {
                    TripHeaderDetailsView(trip: trip, quantityDisplayed: 4)
                    TripHeaderDetailsView(trip: trip, quantityDisplayed: 3)
                    TripHeaderDetailsView(trip: trip, quantityDisplayed: 2)
                }
                Spacer()
            }
            .listRowInsets(EdgeInsets())
        } header: {
            VStack(alignment: .center) {
                IconView(icon: trip.icon, font: .custom("Large Emoji", size: 60))
                HStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "laurel.leading")
                        .foregroundStyle(.secondary)
                    Text(trip.displayName)
                    Image(systemName: "laurel.trailing")
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
            .padding(.bottom, 28)
            .textCase(.none)
            .foregroundStyle(.primary)
            .font(.largeTitle.weight(.semibold))
            .listRowInsets(EdgeInsets())
        }
    }
}

struct TripHeaderDetailsView : View {
    
    var trip: Trip
    var quantityDisplayed: Int = 4
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            InformationTripleView(title: "Location", detail: trip.displayLocation, icon: .systemName("mappin.and.ellipse"))
            
            if quantityDisplayed > 1 {
                Divider()
                    .padding(.vertical, 20)
                
                InformationTripleView(title: "Distance", detail: trip.displayDistance, icon: .systemName("figure.hiking"))
            }
            
            if quantityDisplayed > 2 {
                Divider()
                    .padding(.vertical, 20)
                
                InformationTripleView(title: "Duration", detail: trip.displayDuration, icon: .systemName("timer"))
            }
            
            if quantityDisplayed > 3 {
                Divider()
                    .padding(.vertical, 20)
                
                InformationTripleView(title: "Trip Date", detail: trip.displayDate, icon: .systemName("calendar"))
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct InformationTripleView : View {
    
    var title: String
    var detail: String
    
    var icon: Icon
    
    var body: some View {
        VStack {
            IconView(icon: icon, color: .secondary, font: .title3)
                .frame(height: 30, alignment: .bottom)
            Text(title)
                .font(.caption)
                .textCase(.uppercase)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            Text(detail)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
//                        .font(.caption)
        }
        .padding(.vertical, 5)
    }
}
