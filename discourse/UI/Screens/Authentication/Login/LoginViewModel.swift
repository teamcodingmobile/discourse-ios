//
//  LoginViewModel.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 11/11/2020.
//

import Foundation

protocol LoginCoordinatorDelegate: class {
    func isLogged()
}

class LoginViewModel {
    weak var coordinatorDelegate: LoginCoordinatorDelegate?
    
    
    
    func isLogged(){
        coordinatorDelegate?.isLogged()
    }
    
    
}
