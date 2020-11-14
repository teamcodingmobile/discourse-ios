//
//  LoginForm.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 14/11/2020.
//

import Foundation

class LoginForm: Form {
    var username: String?
    var password: String?
    
    init(username: String?, password: String?) {
        self.username = username
        self.password = password
    }
    
    var fields: [FormField] {
        return [
            FormField(name: "username", value: username, constraints: [.isRequired]),
            FormField(name: "password", value: password, constraints: [.isRequired]),
        ]
    }
}
