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
        
        if authService.isLogged {
            startMainFlow()
        } else {
            startAuthenticationFlow()
        }
    }
    
    func startAuthenticationFlow() {
        let authNavigationController = UINavigationController()
        let authCoordinator = AuthenticationCoordinator(presenter: authNavigationController)
        authCoordinator.delegate = self

        addChildCoordinator(authCoordinator)
        authCoordinator.start()
        
        window.rootViewController = authNavigationController
        window.makeKeyAndVisible()
    }
    
    func startMainFlow() {
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

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func onAuthenticationFlowFinished() {
        startMainFlow()
    }
}
