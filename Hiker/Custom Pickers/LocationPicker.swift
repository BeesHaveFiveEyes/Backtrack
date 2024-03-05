//
//  LocationPicker.swift
//  Hiker
//
//  Created by Alasdair Casperd on 11/12/2023.
//

import SwiftUI
import MapKit

struct LocationPicker: View {
    
    enum LocationDescriptionType {
        case country
        case administrativeArea
        case locality
        case subLocality
    }
    
    var label: String
    var locationDescriptionType: LocationDescriptionType = .locality
    
    @Binding var selection: LocationComponents?
    @Binding var selectionDescription: String?
    
    @State private var showingSheet = false
        
    @State private var position: MapCameraPosition = .automatic
    @State private var localSelection = LocationComponents(latitude: 0, longitude: 0)
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Button(action: showSheet){
                Text(selectionDescription ?? "None")
            }
        }
        .sheet(isPresented: $showingSheet) {
            NavigationStack {
                ZStack {
                    Map(position: $position) {
                        
                    }
                    
                    VStack {
                        HStack {
                            VStack(spacing: 0) {
                                Button(action: { showingSheet = false }){
                                    Image(systemName: "xmark")
                                }
                                .padding(12)
                            }
                            .fixedSize(horizontal: true, vertical: false)
                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
                            Spacer()
                            VStack(spacing: 0) {
                                Button(action: { updateLocation(); showingSheet = false}){
                                    Image(systemName: "checkmark")
                                }
                                .padding(12)
                            }
                            .fixedSize(horizontal: true, vertical: false)
                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
                        }
                        .font(.title3)
                        Spacer()
                        Text("\(localSelection.latitude), \(localSelection.longitude)")
                            .fontWeight(.medium)
                            .padding()
                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
                    }
                    .padding()
                    
                    VStack(alignment: .center) {
                        HStack {
                            Image(systemName: "mappin")
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                                .font(.title)
                        }
                    }
                }
                .onMapCameraChange { newValue in
                    localSelection = LocationComponents.fromLocation(newValue.region.center)
                }
            }
        }
    }
    
    func showSheet() {
        initialiseMapPosition()
        showingSheet = true
    }
    
    func updateLocation() {
        selection = localSelection
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: CLLocationDegrees(localSelection.latitude), longitude: CLLocationDegrees(localSelection.longitude))) { (placemarks, error) in
            guard error == nil else {
                return
            }
                                
            if let firstPlacemark = placemarks?.first {
                switch locationDescriptionType {
                case .country:
                    selectionDescription = firstPlacemark.country
                case .administrativeArea:
                    selectionDescription = firstPlacemark.administrativeArea
                case .locality:
                    selectionDescription = firstPlacemark.locality
                case .subLocality:
                    selectionDescription = firstPlacemark.subLocality
                }
            }
        }
    }
    
    func initialiseMapPosition() {
        if let location = selection {
            position = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(location.latitude), longitude: CLLocationDegrees(location.longitude)), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)))
        }
    }
}

#Preview {
    Form {
        LocationPicker(label: "Start Point", selection: .constant(LocationComponents(latitude: 10, longitude: 10)), selectionDescription: .constant(nil))
            .icon(.systemName("map"))
    }
}
