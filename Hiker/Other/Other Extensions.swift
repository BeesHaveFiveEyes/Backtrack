//
//  Other Extensions.swift
//  Hiker
//
//  Created by Alasdair Casperd on 05/12/2023.
//

import SwiftUI

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
