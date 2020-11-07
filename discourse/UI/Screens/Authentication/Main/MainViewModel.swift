//
//  MainViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 06/11/2020.
//

import Foundation

protocol MainCoordinatorDelegate: class {
    func onRegisterButtonTapped()
    
    func onLoginButtonTapped()
}

class MainViewModel {
    weak var coordinatorDelegate: MainCoordinatorDelegate?
    
    func registerButtonTapped() {
        self.coordinatorDelegate?.onRegisterButtonTapped()
    }
    
    func loginButtonTapped() {
        self.coordinatorDelegate?.onLoginButtonTapped()
    }
}
