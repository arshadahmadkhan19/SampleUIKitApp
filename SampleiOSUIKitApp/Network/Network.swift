//
//  Network.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import Combine
import Foundation

protocol NetworkProtocol {
    func sendRequest(_ request: URLRequest) -> AnyPublisher<Data, Error>
    func sendRequest(_ request: URLRequest) async throws -> Data
}

class Network: NetworkProtocol {
    func sendRequest(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
            guard output.response is HTTPURLResponse else {
                throw NetworkError.invalidAPI
            }
            return output.data
        }.mapError { error in
            return NetworkError.other(error)
        }.eraseToAnyPublisher()
    }
    
    func sendRequest(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard response is HTTPURLResponse else {
            throw NetworkError.invalidAPI
        }
        return data
    }
}

enum NetworkError: Error {
    case invalidAPI
    case other(Error)
}
