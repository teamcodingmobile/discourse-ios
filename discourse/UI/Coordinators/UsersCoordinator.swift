//
//  UsersCoordinator.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation
import Resolver

class UsersCoordinator: Coordinator {
    let presenter: UINavigationController
    @LazyInjected var authService: AuthService
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        guard let userId = authService.loggedUserId, let username = authService.loggedUser else { fatalError() }
        
        let viewModel = UserProfileViewModel(userId: userId,username: username)
        let viewController = UserProfileViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        
        presenter.pushViewController(viewController, animated: true)
    }
}
