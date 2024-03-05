//
//  Icon Modifier.swift
//  Hiker
//
//  Created by Alasdair Casperd on 04/10/2023.
//

import SwiftUI

struct IconModifier: ViewModifier {
    
    var icon: Icon
    var color: Color
    var font: Font
    
    var animator = 0
    var autoAnimate = false
    var symbolEffectOptions: SymbolEffectOptions = .default
    
    func body(content: Content) -> some View {
        HStack {
            IconView(icon: icon, color: color, font: font, animator: animator, autoAnimate: autoAnimate, symbolEffectOptions: symbolEffectOptions)
                .frame(minWidth: 25)
                .padding(.trailing, 5)
            content
        }
    }
}

struct IconView: View {
    
    var icon: Icon
    var color: Color = .primary
    var font: Font = .body
    
    var animator = 0
    var autoAnimate = false
    var symbolEffectOptions: SymbolEffectOptions = .default
    
    @State private var autoAnimateAnimator = 0
    
    var body: some View {
        Group {
            switch icon {
            case .text(let text):
                Text(text)
            case .systemName(let systemName):
                if autoAnimate {
                    Image(systemName: systemName)
                        .symbolEffect(.bounce, value: autoAnimateAnimator)
                        .onAppear {
                            autoAnimateAnimator += 1
                        }
                }
                else {
                    Image(systemName: systemName)
                        .symbolEffect(.bounce, value: animator)
                }
            }
        }
        .foregroundColor(color)
        .font(font)
    }
}

enum Icon: Codable, Hashable {
    case text(_ text: String)
    case systemName(_ name: String)
}

extension View {
    
    func textIcon(text: String, color: Color = .primary, font: Font = .body) -> some View {
        modifier(IconModifier(icon: Icon.text(text), color: color, font: font))
    }
    
    func icon(systemName: String, color: Color = .primary, font: Font = .body) -> some View {
        modifier(IconModifier(icon: Icon.systemName(systemName), color: color, font: font))
    }
    
    func icon(_ icon: Icon, color: Color = .primary, font: Font = .body) -> some View {
        modifier(IconModifier(icon: icon, color: color, font: font))
    }
}
