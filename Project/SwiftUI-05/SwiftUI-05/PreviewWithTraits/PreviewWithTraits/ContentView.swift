//
//  ContentView.swift
//  PreviewWithTraits
//
//  Created by 조성빈 on 4/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.teal
                .frame(width: 200, height: 150)
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                Text("Hello~~")
                    .font(.title2)
            }
            .foregroundStyle(.primary)
            .padding(20)
            .background()
            .border(.tertiary, width: 10)
        }
    }
}

#Preview("Portrait") {
    ContentView()
}

#Preview("Landscape", traits: .landscapeLeft) {
    ContentView()
}

#Preview("Upside down", traits: .portraitUpsideDown) {
    ContentView()
}

#Preview("Size that fits", traits: .sizeThatFitsLayout) {
    ContentView()
}

#Preview("Fixed Layout", traits: .fixedLayout(width: 500, height: 500)) {
    ContentView()
}
