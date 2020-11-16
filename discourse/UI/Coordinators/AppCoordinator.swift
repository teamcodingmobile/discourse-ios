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
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem.title = NSLocalizedString("Search", comment: "")
        searchNavigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        let searchCoordinator = SearchCoordinator(presenter: searchNavigationController)
        
        addChildCoordinator(searchCoordinator)
        searchCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem.title = NSLocalizedString("tabs.profile.title", comment: "")
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person.circle")
        let usersCoordinator = UsersCoordinator(presenter: profileNavigationController)
        
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [topicsNavigationController, searchNavigationController, profileNavigationController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func onAuthenticationFlowFinished() {
        startMainFlow()
    }
}
