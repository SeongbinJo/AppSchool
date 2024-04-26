//
//  ContentView.swift
//  CanvasPreview
//
//  Created by 조성빈 on 4/26/24.
//

import SwiftUI

struct ContentView: View {
    // 기기의 라이트/다크 모드를 감지
    @Environment(\.colorScheme) var deviceColorScheme
    
    
    var body: some View {
        NavigationStack {
            if deviceColorScheme == .light {
                PostView(title: "일반 모드", text: "현재는 다크모드가 아닙니다.", imageName: "sun.max.fill")
            }else {
                PostView(title: "다크 모드", text: "현재는 다크모드입니다.", imageName: "moon.stars.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}
