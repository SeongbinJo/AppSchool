//
//  ContentView.swift
//  UIKitToSwiftUI
//
//  Created by Jungman Bae on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animate = true
    @State private var text = ""
    var body: some View {
        VStack {
            ActivityIndicator(animating: animate)
            HStack {
                Toggle(isOn: $animate) {
                    Text("Toggle Activity")
                }
            }
            .padding()
            
            TextView(text: $text)
                .frame(height: 200)
                .padding()
            
            Text("Entered Text:")
            Text(text)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
