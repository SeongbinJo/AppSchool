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
    case invalidRequestError(String)
    case transportError(Error)
    case validationError(String)
    case decodingError(Error)
    case serverError(statusCode: Int, reason: String? = nil, retryAfter: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case .invalidRequestError(let message):
            return "Invalid request: \(message)"
        case .transportError(let error):
            return "Transport error: \(error)"
        case .invalidResponse:
            return "Invalid response"
        case .validationError(let reason):
            return "Validation error: \(reason)"
        case .decodingError:
            return "The server returned data in an unexpected format. Try updating the app."
        case .serverError(let statusCode, let reason, let retryAfter):
            return "Server error with code \(statusCode), reason: \(reason ?? "no reason"), retryAfter: \(retryAfter ?? "no retry after provided.")"
        }
    }
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
