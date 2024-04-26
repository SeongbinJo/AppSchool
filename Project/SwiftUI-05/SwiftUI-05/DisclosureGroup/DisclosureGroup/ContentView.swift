//
//  ContentView.swift
//  DisclosureGroup
//
//  Created by 조성빈 on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showPlanets = true
    
    var body: some View {
        VStack {
            DisclosureGroup(isExpanded: $showPlanets) {
                Text("Mercury")
                Text("Venus")
                DisclosureGroup("Earth") {
                    Text("North America")
                    Text("South America")
                    Text("Europe")
                    Text("Africa")
                    Text("Asia")
                    Text("Antarctica")
                    Text("Oceania")
                }
                .background(.yellow)
            } label: {
                Text("Planets!")
            }
            .background(.green)
        }
    }
}

#Preview {
    ContentView()
}
