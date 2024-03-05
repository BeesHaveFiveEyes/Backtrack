//
//  DebugInformationView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 05/12/2023.
//

import SwiftUI
import SwiftData

struct DeveloperView: View {
    
    @Query var categories: [Category]
    @Query var packedItems: [PackedItem]
    @Query var items: [Item]
    
    @AppStorage(Settings.welcomeViewSeenKey) var welcomeViewSeen = false
    
    var body: some View {
        Form {
            Section {
                DetailPair(description: "App Version", detail: UIApplication.appVersion ?? "Unknown")
                    .icon(systemName: "app.badge")
            }
            
            Section(header: Text("Greeting Views")) {
                Button("Reset Welcome Sheet") {
                    welcomeViewSeen = false
                }.icon(systemName: "hand.wave", color: .accentColor)
            }
            
            Section(header: Text("App Data")) {
//                DisclosureGroup {
//                    ForEach(categories) { category in
//                        Text(category.name)
//                    }
//                } label: {
//                    DetailPair(description: "Categories", detail: "\(categories.count)")
//                        .icon(systemName: "folder")
//                }
//                
//                DisclosureGroup {
//                    ForEach(packedItems) { packedItem in
//                        DetailPair(description: packedItem.item?.name ?? "Unnamed", detail: "\(packedItem.quantity) X")
//                    }
//                } label: {
//                    DetailPair(description: "Packed Items", detail: "\(packedItems.count)")
//                        .icon(systemName: "backpack")
//                }
                
                DisclosureGroup {
                    ForEach(items) { item in
                        DisclosureGroup {
                            ForEach(item.packedItemInstances) { packedItem in
                                DetailPair(description: packedItem.trip?.name ?? "Missing Trip", detail: packedItem.trip?.displayCaption ?? "")
                            }
                        } label: {
                            DetailPair(description: item.name == "" ? "Unnamed Item" : item.name, detail: "\(item.packedItemInstances.count) trip\(item.packedItemInstances.count == 1 ? "" : "s")")
                        }
                    }
                } label: {
                    DetailPair(description: "Items", detail: "\(items.count)")
                        .icon(systemName: "tray.full")
                }
            }
        }
        .navigationTitle("Developer Dashboard")
    }
}
