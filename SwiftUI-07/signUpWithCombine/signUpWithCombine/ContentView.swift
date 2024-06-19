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
    
    //MARK: - 서버 연결을 위한 프로퍼티
    @Published var isUserNameAvailable: Bool = false
    
    private let authenticationService = AuthenticationService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    var testArray: Array<String> = []
    
    // Bool = Boolean으로 반환, Never = '나는 에러 절대 안낼거야!' 라는 확증
    private lazy var isUsernameLengthValidPublisher: AnyPublisher<Bool, Never> = {
        $username.map { $0.count >= 3 }.eraseToAnyPublisher()
    }()
    
    private lazy var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> = {
        $password.map(\.isEmpty).eraseToAnyPublisher()
    }()
    
    private lazy var isPasswordMatchingPublisher: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest($password, $passwordConfirmation)
            .map(==)
            .eraseToAnyPublisher()
    }()
    
    private lazy var isPasswordValidPublisher: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest(isPasswordEmptyPublisher, isPasswordMatchingPublisher)
            .map { !$0 && $1 }
            .eraseToAnyPublisher()
    }()
    
    private lazy var isFormValidPublisher: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest3(isUsernameLengthValidPublisher, isUsernameAvailablePublisher, isPasswordValidPublisher)
                    .map { $0 && $1 && $2 }
                    .eraseToAnyPublisher()
        }()
  
    // 컴바인 활용할 때는 사용하지 않음!
//    func checkUserNameAvailable(_ userName: String) {
//        authenticationService.checkUserNameAvailableWithClosure(userName: userName) { [weak self] result in
//            DispatchQueue.main.async {
////                print(result)
//                switch result {
//                case .success(let isAvailable):
//                    self?.isUserNameAvailable = isAvailable
//                case .failure(let error):
//                    print("error: \(error)")
//                    self?.isUserNameAvailable = false
//                }
//            }
//        }
//    }
    
    // 컴바인 사용할 경우!
    private lazy var isUsernameAvailablePublisher: AnyPublisher<Bool, Never> = {
        $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates() // 중복 제거
            .flatMap { username -> AnyPublisher<Bool, Never> in
                self.authenticationService.checkUserNameAvailableNaive(userName: username)
                    .catch { error in
                         return Just(false)
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .share()
            .eraseToAnyPublisher()
    }()
    
    init() {
        // debounce -> 오퍼레이터, 특정 시간(초)마다 요청을 보낸다. for : 시간
        // @escaping 사용할 경우
//        $username.debounce(for: 0.5, scheduler: DispatchQueue.main)
//            .sink { [weak self] userName in
//                self?.checkUserNameAvailable(userName)
//            }
//            .store(in: &cancellables)
        
        
        // Reactive 패턴
        // @Published 이므로 $을 붙이고 Operator와 Subscriber를 사용할 수 있다.
//        $username.map { $0.count >= 3 }
//            .assign(to: &$isValid) // 3이상일 경우 isValid = true
//        $username.map { $0.count >= 3 ? "" : "Username must be at least 3 characters."}
//            .assign(to: &$usernameMessage)
        
        // 위와 동일
        isFormValidPublisher.assign(to: &$isValid)
        //        isUsernameLengthValidPublisher.map { $0 ? "" : "Username must be at least 3 characters."}.assign(to: &$usernameMessage)
        
        Publishers.CombineLatest(isUsernameLengthValidPublisher, $isUserNameAvailable)
            .map { isUsernameLengthValid, isUserNameAvailable in
                if !isUsernameLengthValid {
                    return "Username must be at least three characters!"
                } else if !isUserNameAvailable {
                    return "This username is already taken."
                }
                return ""
            }
            .assign(to: &$usernameMessage)
        
        Publishers.CombineLatest(isPasswordEmptyPublisher, isPasswordMatchingPublisher)
            .map { isPasswordEmpty, isPasswordMatching in
                if isPasswordEmpty {
                    return "Password must not be empty"
                }else if !isPasswordMatching {
                    return "Passwords do not match"
                }
                return ""
            }
            .assign(to: &$passwordMessage)
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

