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

struct User: Codable {
    let login: String
    let avatar_url: URL
}

struct ContentView: View {
    
    @State var userName: String = "SeongbinJo"
    @State var repositories: [Repository] = []
    @State var user: User?
    @State var error: Error?
    
    let githubServices = GithubService()
    
    // 여러개의 비동기 처리를 한번에 처리하는 방법 -> actor
    // Fact : 한번에 처리한다고 하지만 순차는 있음.
    actor GithubService {
        func fetchUser(userName: String) async throws -> User {
            let url = URL(string: "https://api.github.com/users/\(userName)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(User.self, from: data)
        }
        
        func fetchRepos(userName: String) async throws -> [Repository] {
            let url = URL(string: "https://api.github.com/users/\(userName)/repos")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Repository].self, from: data)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Github Name : ", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                Task {
                    // 메인 스레드에서 비동기 처리.
                    do {
                        async let fetchUsers = githubServices.fetchUser(userName: userName)
                        async let fetchRepositories = githubServices.fetchRepos(userName: userName)
                        user = try await fetchUsers
                        repositories = try await fetchRepositories
                    } catch {
                        print("Error : \(error)")
                    }
                }
            }) {
                Text("레포지토리 가져오기")
            }
            
            if let user = user {
                AsyncImage(url: user.avatar_url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                
                Text(user.login)
                    .font(.title)
            }
            
            List(repositories) { repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    Text(repo.description ?? "No Description")
                        .font(.subheadline)
                }
            }
            
            if let error = error {
                Text("Error : \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
            
            Button(action: {
                Task.detached {
                    do {
                        let service = GithubService()
                        try await withThrowingTaskGroup(of: Void.self) { group in
                            group.addTask {
                                repositories = try await githubServices.fetchRepos(userName: userName)
                            }
                            group.addTask {
                                user = try await githubServices.fetchUser(userName: userName)
                            }
                            try await group.waitForAll()
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.error = error
                        }
                    }
                }
            }) {
                Text("Fetch Data in Background")
            }
        }
    }
    
    
    
}

#Preview {
    ContentView()
}
