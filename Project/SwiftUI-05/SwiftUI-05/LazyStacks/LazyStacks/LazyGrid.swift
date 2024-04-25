//
//  LazyGrid.swift
//  LazyStacks
//
//  Created by 조성빈 on 4/25/24.
//

import SwiftUI

struct LazyGrid: View {
    
    let columnSpec = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    let rowSpec = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let colors: [Color] = [.green, .red, .yellow, .blue]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columnSpec, spacing: 20) {
                    ForEach(1...999, id: \.self) { index in
                        Text("Item \(index)")
                            .padding(EdgeInsets(top: 20, leading: 15, bottom: 30, trailing: 15))
                            .background(colors[index % colors.count])
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: rowSpec, spacing: 20) {
                    ForEach(1...999, id: \.self) { index in
                        Text("Item \(index)")
                            .padding(EdgeInsets(top: 20, leading: 15, bottom: 30, trailing: 15))
                            .background(colors[index % colors.count])
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
    }
}

#Preview {
    LazyGrid()
}
