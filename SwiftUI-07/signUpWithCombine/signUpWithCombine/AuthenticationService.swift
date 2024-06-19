//
//  AuthenticationService.swift
//  signUpWithCombine
//
//  Created by 조성빈 on 6/19/24.
//

import Foundation
import Combine

struct UserNameAvailableMessage: Codable {
    var isAvailable: Bool
    var userName: String
}

// 에러 만들기
enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

enum APIError: LocalizedError {
    case inValidRequestError(String)
}

class AuthenticationService {
    // @escaping을 사용한 비동기 처리
    func checkUserNameAvailableWithClosure(userName: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/isUserNameAvailable?userName=\(userName)")!
        
        // 비동기 작업 생성
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //MARK: - 안전하게 하기위한 에러 처리
            // 에러가 있다면~
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            // 서버 응답코드가 200번대가 아니면~
            if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            
            // data가 없다면~
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userAvailableMessage = try decoder.decode(UserNameAvailableMessage.self, from: data) // data를 UserNameAvailableMessage의 형태의 값으로 변환!
                completion(.success(userAvailableMessage.isAvailable))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume() // task 수행코드
    }
    
    
    // Combine 퍼블리셔를 사용한 비동기 처리
    func checkUserNameAvailableNaive(userName: String) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: "http://127.0.0.1:8080/isUserNameAvailable?userName=\(userName)") else {
//            return Just(false).eraseToAnyPublisher() // 퍼블리셔를 리턴해야함으로 false를 넣은 Just 퍼블리셔를 리턴! -> 에러를 무시하는 Never일 경우에만!
            return Fail(error: APIError.inValidRequestError("URL invalid")).eraseToAnyPublisher()
        }
        
        //MARK: - 옛날 버전
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map { data, response in
//                do {
//                    let decoder = JSONDecoder()
//                    let userAvailableMessage = try decoder.decode(UserNameAvailableMessage.self, from: data)
//                    return userAvailableMessage.isAvailable
//                } catch {
//                    return false
//                }
//            }
//            .replaceError(with: false) // 흐름(스트림)에 오류가 발생했을 경우 with의 지정해둔 값을 리턴!
//            .eraseToAnyPublisher()
        
        //MARK: - 쌈뽕한 최신 버전 -> 단지 예쁨?
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // data를 가져와서!
            .decode(type: UserNameAvailableMessage.self, decoder: JSONDecoder()) // 가져온 data를 JSONDecoder()로 UserNameAvailableMessage 타입으로 decoding 하고!
            .map(\.isAvailable) // decoding된 값들의 .isAvailable만을 가져와서!
//            .replaceError(with: false) // 흐름(스트림)에 오류가 발생했을 경우 with의 지정해둔 값을 리턴! -> 에러를 무시하는 Never일 경우에만!
            .eraseToAnyPublisher() // AnyPublisher로 바꾼다!!
    }
}
