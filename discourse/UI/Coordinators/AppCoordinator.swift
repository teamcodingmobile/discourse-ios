//
//  AppCoordinator.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 06/11/2020.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        
        let authNavigationController = UINavigationController()
        let authCoordinator = AuthenticationCoordinator(presenter: authNavigationController)

        addChildCoordinator(authCoordinator)
        authCoordinator.start()
        
        window.rootViewController = authNavigationController
        window.makeKeyAndVisible()
    }
}
