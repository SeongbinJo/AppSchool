//
//  ContentView.swift
//  Practice_SignUpCombine_With_Server
//
//  Created by 조성빈 on 6/19/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = SignUpFormViewModel()
    
    var body: some View {
        Form {
            Section(content: {
                TextField("User name", text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }, footer: {
                Text(viewModel.usernameMessage)
                    .foregroundStyle(.red)
            })
            
            Section {
                Button(action: {
                    print("clicked signup button.")
                }) {
                    Text("Sign up")
                }
                .disabled(!viewModel.isValid)
            }
        }
        .alert("Please update", isPresented: $viewModel.showUpdateDialog, actions: {
            Button("Upgrade") {
                
            }
            Button("Not now", role: .cancel) {
                
            }
        }, message: {
            Text("It looks like you're using an older version of this app. Please update your app.")
        })
    }

}

#Preview {
    NavigationStack {
        ContentView()
    }
}
