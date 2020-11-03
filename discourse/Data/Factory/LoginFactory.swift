//
//  LoginFactory.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 03/11/2020.
//

import Foundation
class LoginFactory {
    
    func create(from response: GetLoginResponse) -> UserLogin {
        return UserLogin(
            id: response.user.id,
            username: response.user.username,
            name: response.user.name
        )
    }
}
