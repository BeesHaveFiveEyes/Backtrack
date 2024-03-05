//
//  DistancePicker.swift
//  Hiker
//
//  Created by Alasdair Casperd on 19/12/2023.
//

import SwiftUI

struct DistancePicker: View {

    var text: String
    
    @Binding var distance: Double
    @Binding var unit: DistanceUnit
    
    @State private var localDistance = ""
    @State private var lastValidLocalDistance = ""
    
    @FocusState private var textFieldFocused
    
    var body: some View {
        HStack {
            Text(text)
            
            Spacer()
            
            TextField("none", text: $localDistance)
                .focused($textFieldFocused)
                .onChange(of: localDistance) {
                    if let d = Double(localDistance) {
                        lastValidLocalDistance = localDistance
                        distance = d
                    }
                }
                .onSubmit(formatTextField)
                .toolbar {
                    if textFieldFocused {
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                textFieldFocused = false
                                formatTextField()
                            }
                        }
                    }
                }
                .keyboardType(.decimalPad)
                .frame(maxWidth: 60)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .background{
                    RoundedRectangle(cornerRadius: 7)
                        .foregroundStyle(.backing)
                }
            
            Picker("Units", selection: $unit) {
                Text("km").tag(DistanceUnit.kilometers)
                Text("mi").tag(DistanceUnit.miles)
            }
            .frame(width: 60)
            .labelsHidden()
        }
        .background() {
            Rectangle()
                .opacity(0)
                .contentShape(Rectangle())
                .onTapGesture {
                    textFieldFocused = true
                }
        }
        .task {
            let distanceString = distance == 0 ? "" : "\(distance)"
            localDistance = distanceString
            lastValidLocalDistance = distanceString
        }
    }
    
    func formatTextField() {
        if let d = Double(localDistance) {
            lastValidLocalDistance = localDistance
            distance = d
        } else {
            localDistance = lastValidLocalDistance
        }
    }
}
