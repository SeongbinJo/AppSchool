//
//  Publisher+Dump.swift
//  Practice_SignUpCombine_With_Server
//
//  Created by 조성빈 on 6/20/24.
//

import Foundation
import Combine

extension Publisher {
    func dump() -> AnyPublisher<Self.Output, Self.Failure> {
        handleEvents(receiveOutput: { value in
            Swift.dump(value)
        })
        .eraseToAnyPublisher()
    }
}
