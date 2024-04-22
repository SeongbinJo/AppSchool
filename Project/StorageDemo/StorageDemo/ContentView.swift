//
//  ContentView.swift
//  StorageDemo
//
//  Created by 조성빈 on 4/22/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SceneStorageView()
                .tabItem {
                    Image(systemName: "circle.fill")
                    Text("씬 스토리지")
                }
            AppStorageView()
                .tabItem {
                    Image(systemName: "square.fill")
                    Text("앱 스토리지")
                }
        }
    }
}

#Preview {
    ContentView()
}
