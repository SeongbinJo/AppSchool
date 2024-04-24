//
//  ContentView.swift
//  TheStacks
//
//  Created by Jungman Bae on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("VStack Item 1")
            Text("VStack Item 2")
            Spacer()
            Divider()
                .background(.black)
            Text("VStack Item 3")
            HStack {
                Text("HStack Item 1")
                Text("HStack Item 2")
                Text("HStack Item 3")
            }
            .background(.red)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            ZStack {
                Text("ZStack Item 1")
                    .padding()
                    .background(.green)
                    .opacity(0.8)
//                    .offset(x: -80, y: -400)
                Text("ZStack Item 2")
                    .padding()
                    .background(.green)
//                    .offset(x: 80, y: -400)
            }
            .padding()
        }
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
