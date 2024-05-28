//
//  ContentView.swift
//  JRNL-SwiftUI
//
//  Created by 조성빈 on 5/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            JournalListView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Journal 목록")
                    }
                }
            
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
        }

    }
}

//#Preview {
//    ContentView()
//}
