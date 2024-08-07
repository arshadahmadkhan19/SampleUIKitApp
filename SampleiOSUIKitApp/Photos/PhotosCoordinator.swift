//
//  PhotosCoordinator.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import UIKit


class PhotosCoordinator: Coordinator {
    var childCoordinators: [any Coordinator] = []
    
    var navigationController: UINavigationController?
    
    var parentViewController: UIViewController?
    
    init(navigationController: UINavigationController? = nil, parentViewController: UIViewController? = nil) {
        self.navigationController = navigationController
        self.parentViewController = parentViewController
    }
    
    func start() {
        let photosVC = PhotosViewController(viewModel: PhotosViewModel(service: PhotosService(network: Network())))
        photosVC.photosViewControllerDelegate = self
        navigationController?.pushViewController(photosVC, animated: false)
    }
}

extension PhotosCoordinator: PhotosViewControllerDelegate {
    func photoDetails(photo: PhotoModel) {
        print("Photo details called with photo: \(photo)")
        navigationController?.pushViewController(PhotosDetailViewController(photo: photo), animated: true)
    }
}
