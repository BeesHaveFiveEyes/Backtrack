//
//  ContentView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 04/10/2023.
//

import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
    
    @AppStorage(Settings.welcomeViewSeenKey) var welcomeViewSeen = false
    @AppStorage(Settings.showingDeveloperDashboardKey) var showingDeveloperDashboard = false
    
    static let tripsIcon = "mountain.2"
    static let kitIcon = "backpack"    
    static let mapIcon = "map"
    
    @State private var showingWelcomeView = false
    @State private var showingSettingsSheet = false
    
    @Environment(\.modelContext) var modelContext
    
//    var body: some View {
//        TripsView(showSettingsSheet: {showingSettingsSheet = true})
//    }
    
    var body: some View {
        TabView {
            
            TripsView(showSettingsSheet: {showingSettingsSheet = true})
                .tabItem {
                    Label("Trips", systemImage: ContentView.tripsIcon)
                }
            
            KitView()
                .tabItem {
                    Label("Kit", systemImage: ContentView.kitIcon)
                }
            
            MapView()            
                .tabItem {
                    Label("Map", systemImage: ContentView.mapIcon)
                }
            
            if showingDeveloperDashboard {
                NavigationStack {
                    DeveloperView()
                }
                .tabItem {
                    Label("Dashboard", systemImage: "binoculars")
                }
            }
        }
        .fullScreenCover(isPresented: $showingWelcomeView) {
            GreetingView(greeting: .welcomeGreeting)
        }
        .sheet(isPresented: $showingSettingsSheet) {
            SettingsView()
        }
        .onAppear(perform: initialiseModel)
        .task {
            
            
            // Delete later:
            try? Tips.resetDatastore()
            
            if !welcomeViewSeen {
                showingWelcomeView = true
                welcomeViewSeen = true
            }
        }
    }
    
    func initialiseModel() {
        
        let key = "initialisedCategories"
        
        if !UserDefaults.standard.bool(forKey: key) == true {
            
            // Generate Categories
            let clothing = Category(id: 0, name: "Clothing", icon: .systemName("tshirt"), colorComponents: .fromColor(Color(.purple)))
            
            let sleepSystem = Category(id: 1, name: "Sleep System", icon: .systemName("zzz"), colorComponents: .fromColor(Color(.indigo)))
            
            let shelter = Category(id: 2, name: "Shelter", icon: .systemName("tent"), colorComponents: .fromColor(Color(.blue)))
            
            let cooking = Category(id: 3, name: "Cooking", icon: .systemName("frying.pan"), colorComponents: .fromColor(Color(.teal)))
            
            let tools = Category(id: 4, name: "Tools", icon: .systemName("flashlight.off.fill"), colorComponents: .fromColor(Color(.green)))
                        
            let navigation = Category(id: 5, name: "Navigation", icon: .systemName("map"), colorComponents: .fromColor(Color(.leaf)))
            
            let personal = Category(id: 6, name: "Personal", icon: .systemName("comb"), colorComponents: .fromColor(Color(.yellow)))
            
            let entertainment = Category(id: 7, name: "Entertainment", icon: .systemName("magazine"), colorComponents: .fromColor(Color(.orange)))
            
            let safety = Category(id: 8, name: "Safety", icon: .systemName("bandage"), colorComponents: .fromColor(Color(.red)))
            
            let foodAndWater = Category(id: 9, name: "Food and Water", icon: .systemName("carrot"), colorComponents: .fromColor(Color(.cerise)), consumable: true)
            
            let packing = Category(id: 10, name: "Packing", icon: .systemName("backpack"), colorComponents: .fromColor(Color(.pink)))
            
            let categories = [
                clothing,
                sleepSystem,
                shelter,
                cooking,
                tools,
                navigation,
                personal,
                entertainment,
                safety,
                foodAndWater,
                packing
            ]
            
            for category in categories {
                modelContext.insert(category)
            }
            
            let trip = Trip(name: "Snowdonia Way", icon: Icon.text("⛰️"), distance: 192, locationDescription: "North Wales")
            
            // Packing
            
            let backpack = Item(name: "Backpack", weight: 2220)
            backpack.category = packing
            modelContext.insert(backpack)
            
            let mediumWaterproofBag = Item(name: "Medium Waterproof Bag", weight: 52)
            mediumWaterproofBag.category = packing
            modelContext.insert(mediumWaterproofBag)
            
            let largeWaterproofBag = Item(name: "Large Waterproof Bag", weight: 68)
            largeWaterproofBag.category = packing
            modelContext.insert(largeWaterproofBag)
            
            let waterBag = Item(name: "Water Bag", weight: 80)
            waterBag.category = packing
            modelContext.insert(waterBag)
            
            let waterBottle = Item(name: "Water Bottle", weight: 17)
            waterBottle.category = packing
            modelContext.insert(waterBottle)
            
            // Clothes
            
            let boots = Item(name: "Boots", weight: 724)
            boots.worn = true
            boots.category = clothing
            modelContext.insert(boots)
            
            let socks = Item(name: "Socks", weight: 70)
            socks.worn = true
            socks.category = clothing
            modelContext.insert(socks)
            
            let spareSocks = Item(name: "Spare Socks", weight: 70)
            spareSocks.category = clothing
            modelContext.insert(spareSocks)
            
            let shorts = Item(name: "Shorts", weight: 190)
            shorts.worn = true
            shorts.category = clothing
            modelContext.insert(shorts)
            
            let spareShorts = Item(name: "Spare Shorts", weight: 190)
            spareShorts.category = clothing
            modelContext.insert(spareShorts)
            
            let tshirt = Item(name: "T-Shirt", weight: 130)
            tshirt.worn = true
            tshirt.category = clothing
            modelContext.insert(tshirt)
            
            let spareTshirt = Item(name: "Spare T-Shirt", weight: 130)
            spareTshirt.category = clothing
            modelContext.insert(spareTshirt)
            
            let underwear = Item(name: "Underwear", weight: 72)
            underwear.worn = true
            underwear.category = clothing
            modelContext.insert(underwear)
            
            let spareUnderwear = Item(name: "Spare Underwear", weight: 72)            
            spareUnderwear.category = clothing
            modelContext.insert(spareUnderwear)
            
            let sunhat = Item(name: "Sun Hat", weight: 60)
            sunhat.worn = true
            sunhat.category = clothing
            modelContext.insert(sunhat)
            
            let waterproofJacket = Item(name: "Waterproof Jacket", weight: 310)
            waterproofJacket.category = clothing
            modelContext.insert(waterproofJacket)
            
            let waterproofTrowsers = Item(name: "Waterproof Trowsers", weight: 359)
            waterproofTrowsers.category = clothing
            modelContext.insert(waterproofTrowsers)
            
            let fleece = Item(name: "Fleece", weight: 210)
            fleece.category = clothing
            modelContext.insert(fleece)
            
            let sliders = Item(name: "Sliders", weight: 204)
            sliders.category = clothing
            modelContext.insert(sliders)
            
            UserDefaults.standard.set(true, forKey: key)
        }
    }
}

#Preview {
    ContentView()
}
