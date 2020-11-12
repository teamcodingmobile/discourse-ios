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

class LoginViewModel {
    
    @Injected var httpClient: HttpClient
    weak var coordinatorDelegate: LoginCoordinatorDelegate?
    
    
    func logIn(userInput: String){
        httpClient.login(withUser: userInput) {
            self.isLogged()
            print(self.httpClient.authService.userLogged)
        } onError: { e in
            print("User invalido")
            print(self.httpClient.authService.userLogged)
        }

    }
    
    func isLogged(){
        coordinatorDelegate?.isLogged()
    }
    
}
