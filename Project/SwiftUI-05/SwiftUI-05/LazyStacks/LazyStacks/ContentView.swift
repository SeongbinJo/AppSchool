//
//  ContentView.swift
//  LazyStacks
//
//  Created by 조성빈 on 4/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                // HStack으로 하게되면 10000개를 한 번에 생성하기 때문에 지연시간이 생긴다.
                // LazyHStack은 보여지는 화면만 먼저 생성 후 드래그했을 때 차례로 생기기 때문에 지연시간이 없다.
                LazyHStack {
                    ForEach(1...10000, id: \.self) { item in
                        ListRow(id: item, type: "Horizontal")
                    }
                }
            }
            .frame(height: 100, alignment: .center)
        }
    }
}

#Preview {
    ContentView()
}
