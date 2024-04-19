//
//  GithubViewModel.swift
//  DemoProject-2
//
//  Created by 조성빈 on 4/19/24.
//

import Foundation

// 이 안에서 발생하는 것들을 메인스레드로 처리
@MainActor
class GithubViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var user: User?
    @Published var error: Error?
    
    let githubServices: GithubService = GithubService()
    
    func fetchData(username: String) async {
        // 메인 스레드에서 비동기 처리.
        do {
            async let fetchUsers = githubServices.fetchUser(userName: username)
            async let fetchRepositories = githubServices.fetchRepos(userName: username)
            user = try await fetchUsers
            repositories = try await fetchRepositories
        } catch {
            print("Error : \(error)")
            self.error = error
        }
    }
    
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
}
