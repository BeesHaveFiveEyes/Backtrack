//
//  IconPickerView.swift
//  Hiker
//
//  Created by Alasdair Casperd on 27/11/2023.
//

import SwiftUI

struct IconPickerView: View {
        
    @Binding var selectedIcon: Icon
    var iconSets: [IconSet]
    
    var body: some View {
        NavigationLink {
            IconPickerDetailView(iconSets: iconSets, selectedIcon: selectedIcon) {
                selectedIcon = $0
            }
        } label: {
            HStack {
                Text("Icon")
                    .icon(.systemName("sparkles"))
                Spacer()
                IconView(icon: selectedIcon, color: .secondary)
            }
        }
    }
}

struct IconPickerDetailView: View {
    
    var iconSets: [IconSet]
    
    @Environment(\.presentationMode) var presentationMode
    let columns = [GridItem(.adaptive(minimum: 50), spacing: 14)]
        
    var selectedIcon: Icon
    var setSelection: (Icon) -> ()
    
    var body: some View {
        Form {
            ForEach(iconSets) { iconSet in
                Section {
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(iconSet.icons, id: \.self) { icon in
                            HStack {
                                Spacer()
                                IconView(icon: icon, color: icon == selectedIcon ? .white : .primary.opacity(0.7), font: .title2)
                                    .symbolVariant(.fill)
                                Spacer()
                            }
                            .frame(height: 50)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(icon == selectedIcon ? Color.accentColor : Color(.panel))
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                setSelection(icon)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(EmptyView())
                } header: {
                    Text(iconSet.name)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical)
                }
            }
        }
        .background {
            Color(.backing)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("Choose an Icon")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    
    NavigationView {
        Form {
            IconPickerView(selectedIcon: .constant(.systemName("camera")), iconSets: [.categories, .recommendedEmoji])
        }
        .navigationTitle("Icon Picker View")
    }
}
