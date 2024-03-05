//
//  ImportItemsSheet.swift
//  Hiker
//
//  Created by Alasdair Casperd on 18/10/2023.
//

import SwiftUI

struct ImportItemsSheet: View {
    
    @State private var searchText = ""
    var body: some View {
        NavigationView() {
            Form {                
                Section(header: Text("Search Existing Items")) {
                    List {
                        Text("Tent Inner")
                        Text("Tent Outer")
                        Text("Tent Pegs")
                    }
                    .searchable(text: $searchText)
                }
            }
            .headerProminence(.increased)
//            .navigationTitle("Add Item")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ImportItemsSheet()
}
