////
////  RouteSectionView.swift
////  Hiker
////
////  Created by Alasdair Casperd on 12/12/2023.
////
//
//import SwiftUI
//import SwiftData
//
//struct RouteSectionView: View {
//        
//    @Bindable var section: RouteSection
//    
//    var body: some View {
//        Form {
//            TextField("Section name...", text: $section.name)
//                .icon(systemName: "pencil.line")
//            
//            Section {
//                DistancePicker(text: "Distance", distance: $section.distance, unit: $section.distanceUnit)
//                    .icon(.systemName("figure.hiking"))
//                DistancePicker(text: "Elevation", distance: $section.elevation, unit: $section.elevationUnit)
//                    .icon(.systemName("chart.line.uptrend.xyaxis"))
//            } header: {
//                Text("Section Details")
//            }
//            
//            Section {
//                
//                if section.index > 0 {
//                    Toggle("Continue from Previous", isOn: $section.sharedStartLocation)
//                        .icon(.systemName("play"))
//                }
//                
//                if section.index == 0 || !section.sharedStartLocation {
//                    LocationPicker(label: "Start Point", selection: $section.manualStartLocation, selectionDescription: $section.automaticStartLocationDescription)
//                        .icon(.systemName("mappin.and.ellipse"))
//                }
//                
//            } header: {
//                Text("Section Start")
//            }
//            
//            Section {
//                
//                LocationPicker(label: "End Point", selection: $section.endLocation, selectionDescription: $section.automaticEndLocationDescription)
//                    .icon(.systemName("mappin.and.ellipse"))
//            } header: {
//                Text("Section End")
//            }
//        }
//    }
//}
