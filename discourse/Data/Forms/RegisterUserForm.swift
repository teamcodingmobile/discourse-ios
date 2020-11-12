//
//  RegisterUser.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 08/11/2020.
//

import Foundation

struct RegisterUserForm: Form {
    var username: String?
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
    
    var fields: [FormField] {
        get {
            return [
                FormField(name: "username", value: username, constraints: [.isRequired]),
                FormField(name: "name", value: name, constraints: [.isRequired]),
                FormField(name: "email", value: email, constraints: [.isRequired, .isEmail]),
                FormField(name: "password", value: password, constraints: [.isRequired]),
                FormField(
                    name: "passwordConfirmation",
                    value: passwordConfirmation,
                    constraints: [.isRequired, .isEqualsTo(password, message: "validation.password_mismatch")]
                ),
            ]
        }
    }
}
