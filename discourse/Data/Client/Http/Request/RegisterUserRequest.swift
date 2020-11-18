//
//  RegisterUserRequest.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 07/11/2020.
//

import Foundation

struct RegisterUserRequest: HttpRequest {
    typealias Response = RegisterUserResponse
    
    let data: RegisterUserForm
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/users"
    }
    
    var body: [String : Any] {
        return [
            "username": data.username as Any,
            "name": data.name as Any,
            "email": data.email as Any,
            "password": data.password as Any
        ]
    }
}
