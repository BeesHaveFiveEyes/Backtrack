//
//  SettingsView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 22/10/2023.
//

import SwiftUI

struct Settings {
    static let captionsKey = "captions"
    static let welcomeViewSeenKey = "welcomeViewSeen"
    static let showingDeveloperDashboardKey = "showingDeveloperDashboard"
    static let showingAdvancedSectionKey = "showingAdvancedSection"
}

struct SettingsView: View {
    
    @AppStorage(Settings.captionsKey) var captionsStyle = 0
    @AppStorage(Settings.showingDeveloperDashboardKey) var showingDeveloperDashboard = false
    @AppStorage(Settings.showingAdvancedSectionKey) var showingAdvancedSection = false
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingWelcomeView = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Default Units")) {
                    Text("Distances")
                        .icon(.systemName("ruler"))
                    Text("Item Weights")
                        .icon(.systemName("scalemass"))
                    Text("Weight Totals")
                        .icon(.systemName("scalemass"))
                }
                
                Section(header: Text("Visuals")) {
                    Picker("Trip Subtitles", selection: $captionsStyle) {
                        Text("Location").tag(0)
                        Text("Date").tag(1)
                        Text("Duration").tag(2)
                        Text("Distance").tag(3)
                    }
                    .icon(.systemName("character.textbox"))
                }
                
                Section(header: Text("Categories")){
                    NavigationLink("Manage Categories", destination: EditCategoriesView())
                        .icon(systemName: "folder.badge.gearshape")
                }
                
                if showingAdvancedSection {
                    Section(header: Text("Advanced")){
                        Toggle("Developer Dashboard", isOn: $showingDeveloperDashboard)
                            .icon(systemName: "binoculars")
                    }
                }
                
                Section {
                    Button("Show Welcome Sheet") {
                        showingWelcomeView = true
                    }.icon(systemName: "hand.wave", color: .accentColor)
                    Button("What's New in this Update?") {
                        showingWelcomeView = true
                    }.icon(systemName: "sparkles", color: .accentColor)
                    Button("Reset Settings to Defaults") {
                        showingWelcomeView = true
                    }.icon(systemName: "gearshape.arrow.triangle.2.circlepath", color: .accentColor)
                    Button("Reset App Data") {
                        showingWelcomeView = true
                    }.icon(systemName: "trash", color: .accentColor)
                } footer: {
                    MadeWithHeartView()
                        .onTapGesture(count: 9) {
                            showingAdvancedSection.toggle()
                        }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showingWelcomeView) {
            GreetingView(greeting: .welcomeGreeting)
        }
    }
}

struct MadeWithHeartView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Made with ") + Text("\u{2665}").foregroundColor(.red) + Text(" by Alasdair Casperd")
            Spacer()
        }
        .padding(.vertical, 28)
    }
}
