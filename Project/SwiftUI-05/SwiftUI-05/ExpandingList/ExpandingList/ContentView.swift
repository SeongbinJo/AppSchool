//
//  ContentView.swift
//  ExpandingList
//
//  Created by 조성빈 on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    let bagContent: [Backpack] = [currencies, tools]
    
    var body: some View {
        List(bagContent, children: \.content) { row in
            Label(row.name, systemImage: row.icon)
        }
    }
}

#Preview {
    ContentView()
}
