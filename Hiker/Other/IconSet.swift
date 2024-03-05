//
//  IconSet.swift
//  Hiker
//
//  Created by Alasdair Casperd on 10/12/2023.
//

import Foundation

struct IconSet: Identifiable {
    
    var id = UUID()
    var name: String
    var icons: [Icon]
    
    static var recommendedEmoji = IconSet(name: "Recommended", icons: [
        .text("\u{26F0}"),
        .text("🏔️"),
        .text("🗻"),
        .text("🌋"),
        .text("🏕️"),
        .text("⛺️"),
        .text("🏝️"),
        .text("🏜️"),
        .text("✈️"),
        .text("🚲"),
        .text("🚀"),
        .text("🗺️"),
        .text("⛴️"),
        .text("⛩️"),
        .text("🌾"),
        .text("🍄"),
        .text("🍃"),
        .text("🍁"),
        .text("🌵"),
        .text("🌲"),
        .text("🌳"),
        .text("🌴"),
        .text("🐚"),
        .text("☀️"),
        .text("❄️"),
        .text("🏞️"),
        .text("🌅"),
        .text("🌄"),
        .text("🌇"),
        .text("🌆"),
        .text("🏙️"),
        .text("🌃"),
    ])
    
    static var flags = IconSet(name: "Flags", icons: [
        .text("🇦🇫"),
        .text("🇦🇽"),
        .text("🇦🇱"),
        .text("🇩🇿"),
        .text("🇦🇸"),
        .text("🇦🇩"),
        .text("🇦🇴"),
        .text("🇦🇮"),
        .text("🇦🇶"),
        .text("🇦🇬"),
        .text("🇦🇷"),
        .text("🇦🇲"),
        .text("🇦🇼"),
        .text("🇦🇺"),
    ])
                           
    static var categories = IconSet(name: "Icons", icons: [
        .systemName("tshirt"),
        .systemName("zzz"),
        .systemName("tent"),
        .systemName("tent.2"),
        .systemName("frying.pan"),
        .systemName("flashlight.off.fill"),
        .systemName("map"),
        .systemName("comb"),
        .systemName("magazine"),
        .systemName("bandage"),
        .systemName("carrot"),
        .systemName("backpack"),
        .systemName("figure.hiking"),
        .systemName("signpost.right.and.left"),
        .systemName("mountain.2"),
        .systemName("building.2"),
        .systemName("tree"),
        .systemName("camera"),
        .systemName("bolt"),
        .systemName("figure.outdoor.cycle"),
        .systemName("gamecontroller"),
        .systemName("airplane.departure"),
        .systemName("sailboat"),
        .systemName("book"),
        .systemName("shoeprints.fill"),
        .systemName("cloud.sun.rain"),
        .systemName("snowflake"),
        .systemName("pawprint"),
        .systemName("antenna.radiowaves.left.and.right"),
        .systemName("trash"),
        .systemName("pencil.and.ruler"),
        .systemName("doc.text"),
        .systemName("archivebox"),
        .systemName("tray.full"),
        .systemName("folder"),
    ])
}
