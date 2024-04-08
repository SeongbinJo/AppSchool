//
//  ContentView.swift
//  FirstSwiftUI
//
//  Created by 조성빈 on 4/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("hi")
            Text("Swift")
            HStack {
                Text("hi")
                Text("Swift")
            }
            ZStack {
                Text("hi")
                Text("Swift")
            }
            Button(action: {
                print("clicked!")
            }){
                Text("This is button.")
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
