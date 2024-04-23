//
//  ContentView.swift
//  Buttons
//
//  Created by 조성빈 on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                NavigationLink(destination: ButtonView()) {
                    Text("ButtonView")
                }
                
                NavigationLink(destination: EditButtonView()) {
                    Text("EditButtonView")
                }
                
                NavigationLink(destination: MenuButtonView()) {
                    Text("MenuButtonView")
                }
                
                NavigationLink(destination: PasteButtonView()) {
                    Text("PasteButtonView")
                }
                
                NavigationLink(destination: Text("Very long text that should not be deplayed in a single line because it is not good design.")
                    .padding()
                    .navigationTitle("Detail!")) {
                    Text("Details about text")
                }
            }
            .navigationTitle("Main View")
        }
    }
}

#Preview {
    ContentView()
}
