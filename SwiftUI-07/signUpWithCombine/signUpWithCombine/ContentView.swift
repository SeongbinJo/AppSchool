//
//  ContentView.swift
//  signUpWithCombine
//
//  Created by 조성빈 on 6/18/24.
//

import SwiftUI
import Combine

class SignUpFormViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    
    @Published var usernameMessage: String = ""
    @Published var passwordMessage: String = ""
    @Published var isValid: Bool = false
    
    // Never = '나는 에러 절대 안낼거야!' 라는 확증
    private lazy var isUsernameLengthValidPublisher: AnyPublisher<Bool, Never> = {
        $username.map { $0.count >= 3 }.eraseToAnyPublisher()
    }()
    
    init() {
        // Reactive 패턴
        // @Published 이므로 $을 붙이고 Operator와 Subscriber를 사용할 수 있다.
//        $username.map { $0.count >= 3 }
//            .assign(to: &$isValid) // 3이상일 경우 isValid = true
//        $username.map { $0.count >= 3 ? "" : "Username must be at least 3 characters."}
//            .assign(to: &$usernameMessage)
        // 위와 동일
        isUsernameLengthValidPublisher.assign(to: &$isValid)
        isUsernameLengthValidPublisher.map { $0 ? "" : "Username must be at least 3 characters."}.assign(to: &$usernameMessage)
    }
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
