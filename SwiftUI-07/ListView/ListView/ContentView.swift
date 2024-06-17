//
//  ContentView.swift
//  ListView
//
//  Created by 조성빈 on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            CustomRowView(title: "Apple", subtitle: "Eat one a day")
            CustomRowView(title: "Banana", subtitle: "High in potassium")
            }
        }
    }

private struct CustomRowView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
        }
    }
}

#Preview {
    ContentView()
}
