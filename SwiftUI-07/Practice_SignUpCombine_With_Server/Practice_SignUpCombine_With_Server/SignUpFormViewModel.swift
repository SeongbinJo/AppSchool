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
                       // init() 내부에 isUsernameAvailablePublisher가 두번 사용되는데, 서버에서 값을 가져오는 것을 share함으로써 한 번만 실행되고, 이 가져온 값으로 assign하는걸 두번 하게됨.
                       .share()//서버코드가 들어가있기 때문에 모든 퍼블리셔가 같은 만드는 것 보다 결과를 공유하는게 낫다.
                       .print("share")
                       .eraseToAnyPublisher()
    }()
    
    init() {
        // isUsernameAvailablePublisher 가 두번 사용되었는데, share()가 있어서! isUsernameAvailablePublisher가 수차례 불려도 서버에서 값을 가져오는건 한 번만 가져와진다!! 수차례 불린 퍼블리셔의 오퍼레이터와 섭스크라이버만 수차례 실행됨!
        isUsernameAvailablePublisher.map { result in
            switch result {
            case .success(let isAvailable):
                return isAvailable
            case .failure(let error):
                if case APIError.transportError(_) = error {
                    return true
                }
                return false
            }
        }
        .assign(to: &$isValid)
        
        
        isUsernameAvailablePublisher.map { result in
            switch result {
            case .success(let isAvailable):
                return isAvailable ? "" : "This username is not available."
            case .failure(let error):
                if case APIError.transportError(_) = error {
                    return ""
                }
                else if case APIError.validationError(let reason) = error {
                    return reason
                }
                else if case APIError.serverError(statusCode: _, reason: let reason, retryAfter: _) = error {
                    return reason ?? "Server error"
                }
                return error.localizedDescription
            }
        }
        .assign(to: &$usernameMessage)
        
        isUsernameAvailablePublisher.map { result in
            if case .failure(let error) = result {
                if case APIError.decodingError = error {
                    return true
                }
            }
            return false
        }
        .assign(to: &$showUpdateDialog)
        
    }
    
    
}
