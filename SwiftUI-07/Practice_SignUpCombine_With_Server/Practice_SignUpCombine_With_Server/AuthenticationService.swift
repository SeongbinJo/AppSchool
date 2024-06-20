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
            return Fail(error: APIError.invalidRequestError("URL Invalid")).eraseToAnyPublisher() // 임시 퍼블리셔 반환
        }
        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error -> Error in
                return APIError.transportError(error)
            }
            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
                print("Received response from server, no checking status code")
                
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                if (200..<300) ~= urlResponse.statusCode {} else {
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(APIErrorMessage.self, from: data)
                    
                    if urlResponse.statusCode == 400 {
                        throw APIError.validationError(apiError.reason)
                    }
                    
                    if (500..<600) ~= urlResponse.statusCode {
                        let retryAfter = urlResponse.value(forHTTPHeaderField: "Retry-After")
                        throw APIError.serverError(statusCode: urlResponse.statusCode, reason: apiError.reason, retryAfter: retryAfter)
                    }
                }
                return (data, response)
            }

        return dataTaskPublisher
            .retry(10, withDelay: 3)
            .map(\.data)
            .tryMap { data -> UserNameAvailableMessage in
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(UserNameAvailableMessage.self, from: data)
                } catch {
                    throw APIError.decodingError(error)
                }
            }
            .map(\.isAvailable)
            .eraseToAnyPublisher()
    }
}
