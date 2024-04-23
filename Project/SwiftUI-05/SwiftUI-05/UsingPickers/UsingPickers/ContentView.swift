//
//  ContentView.swift
//  UsingPickers
//
//  Created by 조성빈 on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var choice = 0
    @State private var showText = false
    @State private var transitModes = ["Bike", "Car", "Bus"]
    @State private var sliderValue: Float = 0
    @State private var gameTime = Date()
    
    var body: some View {
        Form {
            Section {
                Picker("Transit modes", selection: $choice) {
                    ForEach(transitModes, id: \.self) { mode in
                        Text("\(mode)")
                    }
                }
                .pickerStyle(.segmented)
                Text("Current choice : \(transitModes[choice])")
            }
            
            Section {
                Toggle(isOn: $showText) {
                    Text("show text")
                }
                if showText {
                    Text("The text toggle is on")
                }
            }
            
            Section {
                Slider(value: $sliderValue, in: 0...10, step: 0.001)
                Text("Slider current value \(sliderValue, specifier: "%.2f")")
            }
        }
    }
}

#Preview {
    ContentView()
}
