//
//  CreateModifier.swift
//  DemoProject
//
//  Created by 조성빈 on 4/18/24.
//

import SwiftUI

// 모디파이어 커스텀 구현
struct StandardTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
        // 모디파이어의 순서에 따라 뷰가 달라짐!
            .font(.custom("Copperplate", size: 58))
            .padding()
            .border(.blue, width: 5)
            .shadow(color: .yellow, radius: 10, x: 5, y: 5)
    }
}

struct CreateModifier: View {
    var body: some View {
        VStack {
            Text("Sample Text")
                .modifier(StandardTitle())
        }
    }
}

#Preview {
    ContentView()
}
