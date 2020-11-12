//
//  AuthenticationCoordinator.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 06/11/2020.
//

import UIKit

class AuthenticationCoordinator: Coordinator {
    let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        let mainViewModel = MainViewModel()
        let mainViewController = MainViewController(viewModel: mainViewModel)
        
        mainViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(mainViewController, animated: true)
    }
}

extension AuthenticationCoordinator: MainCoordinatorDelegate {
    func onRegisterButtonTapped() {
        let viewModel = RegistrationViewModel()
        let viewController = RegistrationViewController(viewModel: viewModel)
        
        viewModel.coordinator = self
        viewModel.delegate = viewController
        
        presenter.pushViewController(viewController, animated: true)
    }
    
    func onLoginButtonTapped() {
        //TODO: Push LoginViewController
    }
}

extension AuthenticationCoordinator: RegistrationViewCoordinator {
    func onSuccessRegistration() {
        //TODO: Go to login
    }
}
