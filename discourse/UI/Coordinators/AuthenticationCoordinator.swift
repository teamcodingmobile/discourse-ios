//
//  AuthenticationCoordinator.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 06/11/2020.
//

import UIKit

protocol AuthenticationCoordinatorDelegate {
    func onAuthenticationFlowFinished()
}

class AuthenticationCoordinator: Coordinator {
    
    var delegate: AuthenticationCoordinatorDelegate?
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
    func goToRegistration() {
        let viewModel = RegistrationViewModel()
        let viewController = RegistrationViewController(viewModel: viewModel)
        
        viewModel.coordinator = self
        viewModel.delegate = viewController
        
        presenter.pushViewController(viewController, animated: true)
    }
    
    func goToLogin() {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        viewModel.coordinatorDelegate = self
        
        presenter.pushViewController(viewController, animated: true)
    }
}

extension AuthenticationCoordinator: PasswordRecoveryCoordinatorDelegate {
    func backToLogin() {
        presenter.popViewController(animated: true)
    }
}

extension AuthenticationCoordinator: LoginCoordinatorDelegate {
    func isLogged() {
        delegate?.onAuthenticationFlowFinished()
    }
    
    func goToRecoverPassword() {
        let viewModel = PasswordRecoveryViewModel()
        let viewController = PasswordRecoveryViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        viewModel.coordinator = self
        
        presenter.pushViewController(viewController, animated: true)
    }
}

extension AuthenticationCoordinator: RegistrationCoordinatorDelegate {
    func onSuccessRegistration() {
        //TODO: Go to login
    }
}
