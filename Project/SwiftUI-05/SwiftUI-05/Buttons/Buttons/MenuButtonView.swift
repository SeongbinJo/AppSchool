//
//  MenuButtonView.swift
//  Buttons
//
//  Created by 조성빈 on 4/23/24.
//

import SwiftUI

struct MenuButtonView: View {
    var body: some View {
        Menu("Choose a country") {
            Button("Canada") { print("Select Canada") }
            Button("Mexico") { print("Select Mexico") }
            Button("USA") { print("Select USA") }
        }
    }
}

#Preview {
    NavigationStack {
        MenuButtonView()
    }
}
