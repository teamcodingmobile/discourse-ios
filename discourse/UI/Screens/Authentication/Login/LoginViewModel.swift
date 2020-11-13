//
//  LoginViewModel.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 11/11/2020.
//

import Foundation
import Resolver

protocol LoginCoordinatorDelegate: class {
    func isLogged()
}
protocol LoginViewDelegate {
    func onLoginError()
}

class LoginViewModel {
    
    @LazyInjected var dataClient: DataClient
    weak var coordinatorDelegate: LoginCoordinatorDelegate?
    var delegate: LoginViewDelegate?
    
    
    func logIn(userInput: String){
        dataClient.login(withUser: userInput) {
            self.isLogged() 
        } onError: { e in
            print("User invalido")
            self.delegate?.onLoginError()
        }

    }
    
    func isLogged(){
        coordinatorDelegate?.isLogged()
    }
    
}
