//
//  Helper.swift
//  Practice_SignUpCombine_With_Server
//
//  Created by 조성빈 on 6/20/24.
//

import Foundation
import Combine

//MARK: - 서버 api로 부터 받음
struct UserNameAvailableMessage: Codable { // 서버에서 받은 데이터를 decoding 해야해서 Codable
    var isAvailable: Bool
    var userName: String
}

//MARK: - API 에러 발생시 에러
struct APIErrorMessage: Decodable {
    var error: Bool // 에러
    var reason: String // 원인
}

//MARK: - 설명
enum APIError: LocalizedError {
    case invalidResponse
}

//MARK: - Publisher 확장
extension Publisher {
    func asResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self
            .map(Result.success)
            .catch { error in
                Just(.failure(error))
            }
            .eraseToAnyPublisher()
    }
}
