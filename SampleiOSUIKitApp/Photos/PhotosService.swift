//
//  PhotosService.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import Combine
import Foundation

protocol PhotosServiceProtocol {
    func getPhotos() -> AnyPublisher<[PhotoModel], Error>
    func getPhotos() async throws -> [PhotoModel]
}

class PhotosService: PhotosServiceProtocol {
    let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getPhotos() -> AnyPublisher<[PhotoModel], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return Fail(error: NetworkError.invalidAPI)
                .eraseToAnyPublisher()
        }
        let request  = URLRequest(url: url)
        return network.sendRequest(request)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getPhotos() async throws -> [PhotoModel] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            throw NetworkError.invalidAPI
        }
        let request  = URLRequest(url: url)
        let data = try await network.sendRequest(request)
        let photos = try JSONDecoder().decode([PhotoModel].self, from: data)
        return photos
    }
}
