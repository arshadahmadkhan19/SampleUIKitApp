//
//  Coordinator.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    var parentViewController: UIViewController? { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var parentViewController: UIViewController?
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let postNavController = UINavigationController()
        postNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let postCoordinator = PostsCoordinator(navigationController: postNavController)
        childCoordinators.append(postCoordinator)
        postCoordinator.start()
        
        let photosNavController = UINavigationController()
        photosNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let photosCoordinator = PhotosCoordinator(navigationController: photosNavController)
        photosCoordinator.start()
        childCoordinators.append(photosCoordinator)
        tabBarController.viewControllers = [postNavController, photosNavController]
    }
}
