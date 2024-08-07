//
//  PostsCoordinator.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import UIKit

class PostsCoordinator: Coordinator {
    var childCoordinators: [any Coordinator] = []
    
    var navigationController: UINavigationController?
    
    var parentViewController: UIViewController?
    
    init(navigationController: UINavigationController? = nil, parentViewController: UIViewController? = nil) {
        self.navigationController = navigationController
        self.parentViewController = parentViewController
    }
    
    func start() {
        let postVC = PostsViewController(viewModel: PostsViewModel(service: PostsService(network: Network())))
        navigationController?.pushViewController(postVC, animated: false)
    }
}
