////
////  WaypointsTestView.swift
////  Hiker
////
////  Created by Alasdair Casperd on 12/12/2023.
////
//
//import SwiftUI
//import MapKit
//
//struct WaypointsTestView: View {
//    
//    @State private var waypoints: [Waypoint] = [
//        Waypoint(id: 0, name: "Conwy Station", location: LocationComponents(latitude: 10, longitude: 4), systemImage: "map"),
//        Waypoint(id: 1, name: "Beddgelert", location: LocationComponents(latitude: 9, longitude: 40), systemImage: "map"),
//    ]
//    
//    var body: some View {
//        Form {
//            Section {
//                ForEach(waypoints) { waypoint in
//                    HStack {
//                        Text("\((waypoints.firstIndex(of: waypoint) ?? 0) + 1)")
//                            .foregroundStyle(Color.accentColor)
//                        Text(waypoint.name)
//                    }
//                }
//                .onMove(perform: move)
//            } header: {
//                Text("Waypoints")
//            }
//            .headerProminence(.increased)
//            
//            Section {
//                ForEach(waypoints) { waypoint in
//                    HStack {
//                        Text("\((waypoints.firstIndex(of: waypoint) ?? 0) + 1)")
//                            .foregroundStyle(Color.accentColor)
//                        Text(waypoint.name)
//                    }
//                }
//                .onMove(perform: move)
//            } header: {
//                Text("Distances")
//            }
//            .headerProminence(.increased)
//            
//            Map {
//                ForEach(waypoints) {waypoint in
//                    if let location = waypoint.location?.location {
////                        Annotation(waypoint.name, coordinate: location) {
////                            Circle()
////                                .frame(width: 30)
////                                .foregroundStyle(Color.teal)
////                                .overlay {
////                                    IconView(icon: waypoint.icon, color: .white)
////                                }
////                        }
//                        Marker(coordinate: location) {
//                            Label(waypoint.name, systemImage: waypoint.systemImage)
//                        }
//                    }
//                }
//            }
//            .listRowInsets(EdgeInsets())
//            .frame(minHeight: 300)
//        }
//        .toolbar {
//            EditButton()
//        }
//    }
//    
//    func move(from source: IndexSet, to destination: Int) {
//        waypoints.move(fromOffsets: source, toOffset: destination)
//    }
//}
//
//#Preview {
//    NavigationStack {
//        WaypointsTestView()
//            .navigationTitle("Route Plan")
//    }
//}
