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
        var myString: String = "File closed"
        if fileOpen {
            myString = "File open"
        }
        return VStack {
            HStack {
                Text(myString)
                    .padding()
                Text("Goodbye, world")
            }
        }
    }
}

#Preview {
    ContentView()
}
