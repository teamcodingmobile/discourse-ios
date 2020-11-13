//
//  RecoverPasswordForm.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import Foundation

struct RecoverPasswordForm: Form {
    
    var username: String?
    
    var fields: [FormField] {
        return [
            FormField(name: "username", value: username, constraints: [.isRequired])
        ]
    }
}
