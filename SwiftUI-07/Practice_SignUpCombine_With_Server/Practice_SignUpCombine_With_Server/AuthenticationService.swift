//
//  serverConnect.swift
//  Practice_SignUpCombine_With_Server
//
//  Created by 조성빈 on 6/19/24.
//

import Foundation
import Combine


struct AuthenticationService {
    func checkUserNameAvailablePublisher(userName: String) -> AnyPublisher<Bool, Error> {
        return Fail(error: APIError.invalidResponse).eraseToAnyPublisher() // 임시 퍼블리셔 반환
    }
}
