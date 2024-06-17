//
//  ContentView.swift
//  SimpleView
//
//  Created by 조성빈 on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    
    var body: some View {
        List {
            Label("Hello World", systemImage: "globe")
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(Color.accentColor)
                Text("Hello World")
            }
            .font(.system(.body, design: .monospaced))
            TextField("TextField", text: $text)
            Button(action: {
                print("Tap button 실행.")
                text = "you tapped me!"
            }) {
                Text("Tap me")
            }
        }
    }
}

#Preview {
    ContentView()
}
