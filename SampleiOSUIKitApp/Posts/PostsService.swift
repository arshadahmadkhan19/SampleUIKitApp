//
//  PostsService.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import Combine
import Foundation

protocol PostsServiceProtocol {
    func getPosts() -> AnyPublisher<[PostsModel], Error>
    func getPosts() async throws -> [PostsModel]
}

class PostsService: PostsServiceProtocol {
    let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getPosts() -> AnyPublisher<[PostsModel], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return Fail(error: NetworkError.invalidAPI)
                .eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return network.sendRequest(request)
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getPosts() async throws -> [PostsModel] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw NetworkError.invalidAPI
        }
        
        let request = URLRequest(url: url)
        let data = try await network.sendRequest(request)
        let posts = try JSONDecoder().decode([PostsModel].self, from: data)
        return posts
    }
}
