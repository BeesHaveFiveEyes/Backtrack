//
//  Animate In Extensions.swift
//  Hiker
//
//  Created by Alasdair Casperd on 04/12/2023.
//

import SwiftUI

struct ScaleIn: ViewModifier {
    
    var delay: Double
    @State private var showingContent = false
    
    func body(content: Content) -> some View {
        
        VStack {
            EmptyView()
            if showingContent {
                content
                    .transition(.scale)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    showingContent = true
                }
            }
        }
    }
}

struct PopIn: ViewModifier {
    
    var delay: Double
    @State private var showingContent = false
    
    func body(content: Content) -> some View {
        
        VStack {
            EmptyView()
            if showingContent {
                content
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    showingContent = true
                }
            }
        }
    }
}

struct FadeIn: ViewModifier {
    
    var delay: Double
    @State private var showingContent = false
    
    func body(content: Content) -> some View {
        
        content.opacity(showingContent ? 1 : 0)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    showingContent = true
                }
            }
        }
    }
}

struct SlideIn: ViewModifier {
    
    var delay: Double
    @State private var showingContent = false
    
    func body(content: Content) -> some View {
        
        VStack {
            EmptyView()
            if showingContent {
                content
                    .transition(.slide.combined(with: .opacity))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    showingContent = true
                }
            }
        }
    }
}

extension View {
        
    func scaleInAfter(_ delay: Double) -> some View {
        modifier(ScaleIn(delay: delay))
    }
    
    func scaleInAfter(offset: Int, withDelay delay: Double = 0.1) -> some View {
        modifier(ScaleIn(delay: 0.15 * Double(offset) + delay))
    }
    
    func fadeInAfter(_ delay: Double) -> some View {
        modifier(FadeIn(delay: delay))
    }
    
    func appearAfter(_ delay: Double) -> some View {
        modifier(PopIn(delay: delay))
    }
    
    func fadeInAfter(offset: Int, withDelay delay: Double = 0.1) -> some View {
        modifier(FadeIn(delay: 0.15 * Double(offset) + delay))
    }
    
    func slideInAfter(_ delay: Double) -> some View {
        modifier(SlideIn(delay: delay))
    }
    
    func slideInAfter(offset: Int, withDelay delay: Double = 0.1) -> some View {
        modifier(SlideIn(delay: 0.15 * Double(offset) + delay))
    }
}
