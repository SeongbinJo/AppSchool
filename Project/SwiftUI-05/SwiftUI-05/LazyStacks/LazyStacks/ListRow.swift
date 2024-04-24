//
//  ListRow.swift
//  LazyStacks
//
//  Created by 조성빈 on 4/24/24.
//

import SwiftUI

struct ListRow: View {
    let id: Int
    let type: String
    
    init(id: Int, type: String) {
        self.id = id
        self.type = type
        print("Loading \(type) item \(id)")
    }
    
    var body: some View {
        Text("\(type) \(id)")
    }
}

#Preview {
    ListRow(id: 1, type: "Horizontal")
}
