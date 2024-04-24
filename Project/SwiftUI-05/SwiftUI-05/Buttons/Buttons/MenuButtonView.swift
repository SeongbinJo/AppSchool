//
//  MenuButtonView.swift
//  Buttons
//
//  Created by Jungman Bae on 4/23/24.
//

import SwiftUI

struct MenuButtonView: View {
    var body: some View {
        Menu("Choose a country") {
            Button("Canada") { print("Select Canada") }
            Button("Mexico") { print("Select Mexico") }
            Button("USA") { print("Select USA") }
        }
        .navigationTitle("MenuButton")
    }
}

#Preview {
    NavigationStack {
        MenuButtonView()
    }
}
