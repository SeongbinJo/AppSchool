//
//  ContentView.swift
//  testDemo
//
//  Created by 조성빈 on 4/22/24.
//

import SwiftUI
import SwiftData

@Model
class Memo {
    var id: UUID = UUID()
    var text: String
    var createDate: Date
    
    init(text: String, createDate: Date) {
        self.text = text
        self.createDate = createDate
    }
}

struct ContentView: View {
    
    @Query(sort: \Memo.text) var memos: [Memo]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
