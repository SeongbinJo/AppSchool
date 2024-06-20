//
//  Publisher+Retry.swift
//  Practice_SignUpCombine_With_Server
//
//  Created by 조성빈 on 6/20/24.
//

import Foundation
import Combine

extension Publisher {
    func retry<T, E> (_ retryCount: Int, withDelay delay: Int, condition: ((E) -> Bool)? = nil) -> Publishers.TryCatch<Self, AnyPublisher<T, E>> where T == Self.Output, E == Self.Failure {
        return self.tryCatch { error -> AnyPublisher<T, E> in
            if condition?(error) == true {
                return Just(Void())
                    .delay(for: .init(integerLiteral: delay), scheduler: DispatchQueue.global())
                    .flatMap { _ in
                        return self
                    }
                    .retry(retryCount)
                    .eraseToAnyPublisher()
            } else {
                throw error
            }
        }
    }
}
