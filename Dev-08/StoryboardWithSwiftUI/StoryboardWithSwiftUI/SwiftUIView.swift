//
//  SwiftUIView.swift
//  StoryboardWithSwiftUI
//
//  Created by 조성빈 on 7/8/24.
//

import SwiftUI

struct SwiftUIView: View {
    var name: String
    
    
    var body: some View {
        Text("Hello, \(name)")
    }
}

#Preview {
    SwiftUIView(name: "성빈")
}
