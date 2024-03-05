//
//  Tips.swift
//  Hiker
//
//  Created by Alasdair Casperd on 12/12/2023.
//

import SwiftUI
import TipKit

struct KitLibraryTip: Tip {
    var title: Text {
        Text("Share Kit Between Trips")
    }
 
    var message: Text? {
        Text("Catalogue your kit to reuse it across all of your trips. New items added to trips are saved here automatically.")
    }
 
    var image: Image? {
        Image(systemName: ContentView.kitIcon)
    }
}

struct NewTripTip: Tip {
    var title: Text {
        Text("Create a Trip")
    }
 
    var message: Text? {
        Text("To get started, create your first trip.")
    }
 
    var image: Image? {
        Image(systemName: "mountain.2")
    }
}
