//
//  ContentView.swift
//  ApiTest
//
//  Created by 조성빈 on 4/29/24.
//

import SwiftUI


struct ContentView: View {
    // now_playing => 현재 상영중인 영화
    // language=ko-KR => 언어 - 한글
    // region=KR => 지역 - 한국
    let movieURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=a09219f6866ad10f5ffe9011ad4afadb&language=ko-KR&region=KR&page=1"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            getMovie()
        }
    }
    
    func getMovie() {
        guard let url = URL(string: movieURL) else {
            print("movieURL is empty.")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
                // 에러를 체크합니다.
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // 데이터를 확인하고 콘솔에 출력합니다.
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print(jsonString)
                    } else {
                        print("Failed to convert data to string")
                    }
                }
            }.resume()
    }
}

#Preview {
    ContentView()
}
