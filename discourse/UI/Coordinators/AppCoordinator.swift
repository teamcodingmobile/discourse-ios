//
//  AppCoordinator.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 06/11/2020.
//

import UIKit
import Resolver

class AppCoordinator: Coordinator {
    let window: UIWindow
    @Injected var authService: AuthService
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let authNavigationController = UINavigationController()
        let authCoordinator = AuthenticationCoordinator(presenter: authNavigationController)

        addChildCoordinator(authCoordinator)
        authCoordinator.start()
        
        let topicsNavigationController = UINavigationController()
        topicsNavigationController.tabBarItem.title = NSLocalizedString("tabs.topics.title", comment: "")
        topicsNavigationController.tabBarItem.image = UIImage(systemName: "message.circle")
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController)
        
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [topicsNavigationController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
