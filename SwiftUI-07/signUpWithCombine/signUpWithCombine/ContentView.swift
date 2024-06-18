//
//  ContentView.swift
//  signUpWithCombine
//
//  Created by 조성빈 on 6/18/24.
//

import SwiftUI

class SignUpFormViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    
    @Published var usernameMessage: String = ""
    @Published var passwordMessage: String = ""
    @Published var isValid: Bool = false
}

struct ContentView: View {
    @StateObject var viewModel = SignUpFormViewModel()
    
    var body: some View {
        Form {
            Section(content: {
                TextField("Username", text: $viewModel.username)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
            }, footer: {
                Text(viewModel.usernameMessage)
                    .foregroundStyle(.red)
            })
            
            Section(content: {
                SecureField("Password", text: $viewModel.password)
                SecureField("Repeat password", text: $viewModel.passwordConfirmation)
            }, footer: {
                Text(viewModel.passwordMessage)
                    .foregroundStyle(.red)
            })
            
            Section {
                Button("Sign up") {
                    print("Signing up as \(viewModel.username)")
                }
                .disabled(!viewModel.isValid)
            }
        }
    }
}
    
    #Preview {
        ContentView()
    }
