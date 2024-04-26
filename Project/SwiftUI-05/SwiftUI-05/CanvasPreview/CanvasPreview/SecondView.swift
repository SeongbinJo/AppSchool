//
//  SecondView.swift
//  CanvasPreview
//
//  Created by 조성빈 on 4/26/24.
//

import SwiftUI

struct SecondView: View {
    var someText: String
    
    var body: some View {
        Text(someText)
            .navigationTitle("Second View.")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("SecondView") {
    NavigationStack {
        SecondView(someText: "asdf")
    }
}
