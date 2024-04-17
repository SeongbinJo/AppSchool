//
//  ContentView.swift
//  DemoProject
//
//  Created by 조성빈 on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Text 1")
                Text("Text 2")
            }
            HStack {
                Text("Text 3")
                Text("Text 4")
            }
        }
        Text("Text 5")
    }
}

#Preview {
    ContentView()
}
