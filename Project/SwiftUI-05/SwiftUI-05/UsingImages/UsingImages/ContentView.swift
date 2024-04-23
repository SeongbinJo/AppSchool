//
//  ContentView.swift
//  UsingImages
//
//  Created by 조성빈 on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(.gecko2) // "gecko-1"과 동일
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image(.gecko1)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 200)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.blue, lineWidth: 5)
                }
                .shadow(radius: 10)
            Image(uiImage: UIImage(resource: .gecko3))
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    ContentView()
}
