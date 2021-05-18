//
//  MockRequestManager.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import Foundation
import Combine

enum MockRequest {
    case home
    case error
}

enum MockError: Error {
    case generalError
}

final class MockRequestManager {
    static let shared = MockRequestManager()

    func send(_ request: MockRequest) -> AnyPublisher<[NumberOption], MockError> {
        let response = PassthroughSubject<[NumberOption], MockError>()
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
            switch request {
            case .home:
                response.send(NumberOption.allCases)
            case .error:
                response.send(completion: .failure(.generalError))
            }
        }
        return response.eraseToAnyPublisher()
    }
}
