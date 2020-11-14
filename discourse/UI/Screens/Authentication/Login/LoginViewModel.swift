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
    
    func goToRecoverPassword()
}

protocol LoginViewDelegate {
    
    func onLoginDataErrors(_ errors: [FormError])
    func onLoginError()
    
}

class LoginViewModel {
    @LazyInjected var formValidator: FormValidator
    @LazyInjected var dataClient: DataClient
    weak var coordinatorDelegate: LoginCoordinatorDelegate?
    var delegate: LoginViewDelegate?
    
    
    func logIn(withData data: LoginForm){
        let errors = formValidator.validate(data)
        
        if !errors.isEmpty {
            delegate?.onLoginDataErrors(errors)
            return
        }
        
        dataClient.login(withData: data) {
            self.isLogged() 
        } onError: { e in
            print("User invalido")
            self.delegate?.onLoginError()
        }

    }
    
    func recoverPassword() {
        coordinatorDelegate?.goToRecoverPassword()
    }
    
    func isLogged(){
        coordinatorDelegate?.isLogged()
    }
    
}
