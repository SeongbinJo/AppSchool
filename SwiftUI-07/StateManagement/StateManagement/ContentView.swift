//
//  ContentView.swift
//  StateManagement
//
//  Created by 조성빈 on 6/17/24.
//

import SwiftUI

struct ParentView: View {
    @State var favoriteNumber: Int = 42
    
    var body: some View {
        VStack {
            Text("Your favorite number is \(favoriteNumber)")
            ChildView(number: $favoriteNumber)
        }
        .padding()
    }
}

struct ChildView: View {
    @Binding var number: Int
    var body: some View {
        Text("\(number)")
    }
}

#Preview {
    ParentView()
}
