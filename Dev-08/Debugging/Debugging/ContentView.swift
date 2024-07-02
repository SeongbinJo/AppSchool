//
//  ContentView.swift
//  Debugging
//
//  Created by 조성빈 on 7/1/24.
//

import SwiftUI

struct ContentView: View {
    @State var message = "Temperature in Celsius"
    let temp = 100.0
    
    var body: some View {
        VStack {
            Text(message + "\(temp)")
            Text("Temperature in Fahrenheit: \(C2F(tempC: temp))")
        }
        .padding()
    }
    
    func C2F(tempC: Double) -> Double {
        var tempF: Double
        tempF = tempC + 32 * 9/5
        return tempF
    }
}

#Preview {
    ContentView()
}
