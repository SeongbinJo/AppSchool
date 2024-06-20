//
//  SignUpViewModel.swift
//  Practice_SignUpCombine_With_Server
//
//  Created by 조성빈 on 6/19/24.
//

import Foundation
import Combine

class SignUpFormViewModel: ObservableObject {
    typealias Available = Result<Bool, Error>
    
    @Published var username: String = ""
    @Published var usernameMessage: String = ""
    
    @Published var isValid: Bool = false
    
    @Published var showUpdateDialog: Bool = false
    
    private var authenticationService = AuthenticationService()
    
    private lazy var isUsernameAvailablePublisher: AnyPublisher<Available, Never> = {
        $username
            .debounce(for: 0.5, scheduler: RunLoop.main) // 특정 이벤트가 여러번 나타날때(username의 키보드 입력) 이벤트 입력으로부터 0.5초가 지나면 그 이벤트를 처리!
            .removeDuplicates() // 새로운 마지막 이벤트가 이전의 username과 동일하면 무시해버림!
            .flatMap { username -> AnyPublisher<Available, Never> in
                self.authenticationService.checkUserNameAvailablePublisher(userName: username)
                    .asResult()
            }
            .receive(on: DispatchQueue.main)
                       .print("before share")
                       .share()//서버코드가 들어가있기 때문에 모든 퍼블리셔가 같은 만드는 것 보다 결과를 공유하는게 낫다.
                       .print("share")
                       .eraseToAnyPublisher()
    }()
    
    init() {
            isUsernameAvailablePublisher.map { result in
                switch result {
                case .success(let isAvailable):
                    return isAvailable
                case .failure(_):
                    return false
                }
            }
            .assign(to: &$isValid)
        
        
        isUsernameAvailablePublisher.map { result in
                    switch result {
                    case .success(let isAvailable):
                        return isAvailable ? "" : "This username is not available."
                    case .failure(let error):
                        return error.localizedDescription
                    }
                }
                .assign(to: &$usernameMessage)
        }
    
    
}
