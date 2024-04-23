//
//  BlueCircle.swift
//  UsingViewBuilder
//
//  Created by 조성빈 on 4/23/24.
//

import SwiftUI

// Content라는 제네릭 타입을 가짐.
struct BlueCircle<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
            Spacer()
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 30)
        }
        .padding()
    }
}
