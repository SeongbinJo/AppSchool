//
//  PostView.swift
//  CanvasPreview
//
//  Created by 조성빈 on 4/26/24.
//

import SwiftUI

struct PostView: View {
    var title: String
    var text: String
    var imageName: String
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if geometry.size.height > geometry.size.width {
                    VStack(spacing: 20) {
                        Image(systemName: imageName)
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.75)
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.title2)
                                .padding(.top)
                            Text(text)
                                .padding(.top)
                        }
                    }
                }else {
                    HStack(spacing: 20) {
                        Image(systemName: imageName)
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.height * 0.55)
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.title2)
                                .padding(.top)
                            Text(text)
                                .padding(.top)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    PostView(title: "Weather forcast", text: "꽁꽁 얼어붙은 한강위로 고양이가 쌈뽕하게 춤을 춥니다.", imageName: "cloud.snow")
}
