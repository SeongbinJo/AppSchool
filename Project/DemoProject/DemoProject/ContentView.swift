//
//  ContentView.swift
//  DemoProject
//
//  Created by 조성빈 on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var fileOpen: Bool = true
    
    var body: some View {
        VStack {
            VStack {
                Text("Text 1")
                Text("Text 2")
            }
            MyHStackView()
        }
    }
}

struct MyHStackView: View {
    var body: some View {
        HStack {
            Text("Text 3")
            Text("Text 4")
        }
    }
}

#Preview {
    ContentView()
}
