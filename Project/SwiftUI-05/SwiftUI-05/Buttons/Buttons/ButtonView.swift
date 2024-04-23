//
//  ButtonView.swift
//  Buttons
//
//  Created by 조성빈 on 4/23/24.
//

import SwiftUI

struct ButtonView: View {
    @State var count = 0
    
    var body: some View {
        VStack {
            Text("Welcome to your second view")
            Text("Current count value : \(count)")
            Button(action : {
                count += 1
            }) {
                Text("Tap to Increment count")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(Capsule())
            }
        }
        .navigationTitle("Button View")
    }
}

#Preview {
    NavigationStack {
        ButtonView()
    }
}
