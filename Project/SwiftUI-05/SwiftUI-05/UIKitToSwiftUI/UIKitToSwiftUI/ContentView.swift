//
//  ContentView.swift
//  UIKitToSwiftUI
//
//  Created by 조성빈 on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animate = true
    var body: some View {
        VStack {
            ActivityIndicator(animating: animate)
            HStack {
                Toggle(isOn: $animate) {
                    Text("Toggle Activity")
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
