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
    
    @StateObject var gitVM: GithubViewModel = GithubViewModel()
    @State var userName: String = "SeongbinJo"
    
    var body: some View {
        VStack {
            TextField("Github Name : ", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                Task {
                    await gitVM.fetchData(username: userName)
                }
            }) {
                Text("레포지토리 가져오기")
            }
            
            if let user = gitVM.user {
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
            
            List(gitVM.repositories) { repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    Text(repo.description ?? "No Description")
                        .font(.subheadline)
                }
            }
            
            if let error = gitVM.error {
                Text("Error : \(error.localizedDescription)")
                    .foregroundColor(.red)
            }

        }
    }
    
    
    
}

#Preview {
    ContentView()
}
