//
//  AuthenticationService.swift
//  signUpWithCombine
//
//  Created by 조성빈 on 6/19/24.
//

import Foundation

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

class AuthenticationService {
    func checkUserNameAvailableWithClosure(userName: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/isUserNameAvailable?userName=\(userName)")!
        
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
}
