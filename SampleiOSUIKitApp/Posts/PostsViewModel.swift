//
//  PostsViewModel.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import Foundation
import Combine

protocol PostsViewModelProtocol {
    func getPosts() -> AnyPublisher<[PostsModel], Error>
}
 
class PostsViewModel: PostsViewModelProtocol {
    let service: PostsServiceProtocol
    init(service: PostsServiceProtocol) {
        self.service = service
    }
    
    func getPosts() -> AnyPublisher<[PostsModel], Error> {
        service.getPosts().eraseToAnyPublisher()
    }
}
