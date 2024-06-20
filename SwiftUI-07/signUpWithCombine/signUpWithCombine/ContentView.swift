//
//  ContentView.swift
//  signUpWithCombine
//
//  Created by 조성빈 on 6/18/24.
//

import SwiftUI
import Combine

extension Publisher {
    func asResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { error in
                Just(.failure(error))
            }
            .eraseToAnyPublisher()
    }
}

class SignUpFormViewModel: ObservableObject {
    typealias Available = Result<Bool, Error>
    
    
    // @Published 퍼블리셔들은 Failure의 타입이 Never이므로 에러 핸들링이 반드시 필요하다! ex) Just(false) 등
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
            .map { isUsernameLengthValid, isUsernameAvailable, isPasswordValid in
                switch isUsernameAvailable {
                case .success(let isAvailable):
                    return isUsernameLengthValid && isAvailable && isPasswordValid
                case .failure:
                    return false
                }
            }
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
    private lazy var isUsernameAvailablePublisher: AnyPublisher<Available, Never> = {
        $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates() // 중복 제거
            .flatMap { username -> AnyPublisher<Available, Never> in
                self.authenticationService.checkUserNameAvailableNaive(userName: username)
                    .asResult()
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
        
        
        // @Published 이므로 $을 붙이고 Operator와 Subscriber를 사용할 수 있다.
//        $username.map { $0.count >= 3 }
//            .assign(to: &$isValid) // 3이상일 경우 isValid = true
//        $username.map { $0.count >= 3 ? "" : "Username must be at least 3 characters."}
//            .assign(to: &$usernameMessage)
        
        // 위와 동일
        isFormValidPublisher.assign(to: &$isValid)
        //        isUsernameLengthValidPublisher.map { $0 ? "" : "Username must be at least 3 characters."}.assign(to: &$usernameMessage)
        
        Publishers.CombineLatest(isUsernameLengthValidPublisher, isUsernameAvailablePublisher)
            .map { isUsernameLengthValid, isUserNameAvailable in
                switch (isUsernameLengthValid, isUserNameAvailable) {
                case (false, _):
                    return "Username must be at least three characters!"
                case (_, .failure(let error)): // 서버가 연결이 안되어 확인이 불가!
                    return "Error checking username availability: \(error.localizedDescription)"
                case (_, .success(false)): // 서버에 연결이 되었지만 이미 존재함!
                    return "This username is already taken."
                default:
                    return ""
                }
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

