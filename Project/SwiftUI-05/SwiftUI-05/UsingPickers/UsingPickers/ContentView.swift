//
//  ContentView.swift
//  UsingPickers
//
//  Created by Jungman Bae on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var choice = 0
    @State private var showText = false
    @State private var transitModes = ["Bike", "Car", "Bus"]
    @State private var sliderVal: Float = 0
    @State private var gameTime = Date()
    
    var body: some View {
        Form {
            Section {
                Picker("Transit modes", selection: $choice) {
                    ForEach( 0..<transitModes.count, id: \.self) { index in
                        Text("\(transitModes[index])")
                    }
                }
                .pickerStyle(.segmented)
                Text("Current choice: \(transitModes[choice])")
            }
            
            Section {
                Toggle(isOn: $showText) {
                    Text("Show Text")
                }
                if showText {
                    Text("The Text toggle is on")
                }
            }
            
            Section {
                Slider(value: $sliderVal, in: 0...10, step: 0.001)
                Text("Slider current value \(sliderVal, specifier: "%.2f")")
            }
        }
    }
}

#Preview {
    ContentView()
}
