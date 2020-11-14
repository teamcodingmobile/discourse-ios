//
//  PasswordRecoveryViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import Foundation
import Resolver

protocol PasswordRecoveryCoordinatorDelegate {
    func backToLogin()
}

protocol PasswordRecoveryViewDelegate {
    func onInvalidPasswordRecoveryData(_ errors: [FormError])
    
    func onSuccessPasswordRecovery()
    
    func onPasswordRecoveryError(_ error: Error?)
}

class PasswordRecoveryViewModel {
    var delegate: PasswordRecoveryViewDelegate?
    var coordinator: PasswordRecoveryCoordinatorDelegate?
    @LazyInjected var formValidator: FormValidator
    @LazyInjected var dataClient: DataClient
    
    func recover(data: RecoverPasswordForm) {
        let errors = formValidator.validate(data)
        
        if !errors.isEmpty {
            delegate?.onInvalidPasswordRecoveryData(errors)
            
            return
        }
        
        dataClient.recoverPassword(withData: data) { [weak self] in
            self?.delegate?.onSuccessPasswordRecovery()
        } onError: { [weak self] (error) in
            self?.delegate?.onPasswordRecoveryError(error)
        }
    }
    
    func goToLogin() {
        coordinator?.backToLogin()
    }
}
