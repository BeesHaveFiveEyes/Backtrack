//
//  PanelButton.swift
//  Hiker
//
//  Created by Alasdair Casperd on 28/11/2023.
//

import SwiftUI

struct PanelButton: View {
    
    var label: String
    var icon: Icon
    var action: () -> ()
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                VStack {
                    IconView(icon: icon, color: .accentColor, font: .title)
                        .frame(minHeight: 40, alignment: .bottom)
                        .padding(.bottom, 7)
                    Text(label)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
        }
        .frame(height: 100)
        .background {
            RoundedRectangle(cornerRadius: 9)
                .foregroundStyle(.panel)
        }
    }
}

#Preview {
    Form {
        EmptyTripView()
    }
}
