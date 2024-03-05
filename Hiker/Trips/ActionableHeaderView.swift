//
//  ActionableHeaderView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 28/11/2023.
//

import SwiftUI

struct ActionableHeaderView: View {
    
    var title: String
    var action: (() -> ())?
    var actionTitle: String = "Edit"
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color.primary)
                .textCase(.none)
            
            Spacer()
            
            if let buttonAction = action {
                Button(actionTitle, action: buttonAction)
                    .font(.system(size: 16, weight: .bold))                    
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background {
                        Capsule()
                            .fill(Color(UIColor.systemGray5))
                    }                
            }
        }
        .textCase(.none)
        .listRowInsets(EdgeInsets())
        .padding(.top, 30)
        .padding(.bottom)
    }
}

#Preview {
    Form {
        Section {
          Text("Content")
        } header: {
            ActionableHeaderView(title: "Weight Distribution")
        }
    }
}
