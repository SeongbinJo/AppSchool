//
//  PreviewInNavigationStack.swift
//  CanvasPreview
//
//  Created by 조성빈 on 4/26/24.
//

import SwiftUI

struct PreviewInNavigationStack: View {
    var body: some View {
        NavigationStack {
            NavigationLink(destination: SecondView(someText: "Text passed from PreviewInNavigationStack View")) {
                Text("Go to second view")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .navigationTitle("Previews")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PreviewInNavigationStack()
}
