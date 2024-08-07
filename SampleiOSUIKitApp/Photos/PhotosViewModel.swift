//
//  PhotosViewModel.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import Combine
import Foundation

protocol PhotosViewModelProtocol {
    func getPhotos() -> AnyPublisher<[PhotoModel], Error>
}

class PhotosViewModel: PhotosViewModelProtocol {
    let service: PhotosService
    init(service: PhotosService) {
        self.service = service
    }
    
    func getPhotos() -> AnyPublisher<[PhotoModel], Error> {
        service.getPhotos().eraseToAnyPublisher()
    }
}
