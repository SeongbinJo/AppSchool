//
//  ContentView.swift
//  DemoProject-2
//
//  Created by 조성빈 on 4/19/24.
//

import SwiftUI

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
}

struct ContentView: View {
    
    @State var userName: String = "SeongbinJo"
    @State var repositories: [Repository] = []
    
    var body: some View {
        VStack {
            TextField("Github Name : ", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                Task {
                    do {
                        async let fetchRepositories = fetchRepos(userName: userName)
                        repositories = try await fetchRepositories
                    } catch {
                        print("Error : \(error)")
                    }
                }
            }) {
                Text("레포지토리 가져오기")
            }
            List(repositories) { repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    Text(repo.description ?? "No Description")
                        .font(.subheadline)
                }
            }
        }
    }
    
    func fetchRepos(userName: String) async throws -> [Repository] {
        let url = URL(string: "https://api.github.com/users/\(userName)/repos")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Repository].self, from: data)
    }
    
}

#Preview {
    ContentView()
}
