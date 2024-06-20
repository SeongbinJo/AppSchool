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
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
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
        }
}
