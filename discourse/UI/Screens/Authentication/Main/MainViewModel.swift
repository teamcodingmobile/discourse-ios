//
//  MainViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 06/11/2020.
//

import Foundation

protocol MainCoordinatorDelegate: class {
    func goToRegistration()
    
    func goToLogin()
}

class MainViewModel {
    weak var coordinatorDelegate: MainCoordinatorDelegate?
    
    func registerButtonTapped() {
        self.coordinatorDelegate?.goToRegistration()
    }
    
    func loginButtonTapped() {
        self.coordinatorDelegate?.goToLogin()
    }
}
