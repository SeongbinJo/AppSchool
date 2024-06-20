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
        guard let url = URL(string: "http://127.0.0.1:8080/isUserNameAvailable?userName=\(userName)") else {
            return Fail(error: APIError.invalidResponse).eraseToAnyPublisher() // 임시 퍼블리셔 반환
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: UserNameAvailableMessage.self, decoder: JSONDecoder())
            .map(\.isAvailable)
            .eraseToAnyPublisher()
    }
}
