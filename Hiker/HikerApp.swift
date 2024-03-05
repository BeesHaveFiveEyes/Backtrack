//
//  HikerApp.swift
//  Hiker
//
//  Created by Alasdair Casperd on 03/10/2023.
//

import SwiftUI
import TipKit

@main
struct HikerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
        .modelContainer(for: Trip.self)
    }
}
