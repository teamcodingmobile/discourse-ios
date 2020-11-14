//
//  RegistrationViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 07/11/2020.
//

import Foundation
import Resolver

protocol RegistrationCoordinatorDelegate {
    func onSuccessRegistration()
}

protocol RegistrationViewDelegate {
    func onInvalidRegistrationData(_ errors: [FormError])
    func onRegistrationError(_ error: Error?)
}

protocol RegisterUserFormValidator {
    func validate(_ data: RegisterUserForm) -> [FormError]
}

class RegistrationViewModel {
    var coordinator: RegistrationCoordinatorDelegate?
    var delegate: RegistrationViewDelegate?
    @LazyInjected var dataClient: DataClient
    @LazyInjected var formValidator: FormValidator
    
    func register(data: RegisterUserForm) {
        let errors = formValidator.validate(data)
        
        if !errors.isEmpty {
            self.delegate?.onInvalidRegistrationData(errors)
            
            return
        }
        
        dataClient.registerUser(withData: data) { [weak self] in
            self?.coordinator?.onSuccessRegistration()
        } onError: { [weak self] (error) in
            self?.delegate?.onRegistrationError(error)
        }
    }
}
