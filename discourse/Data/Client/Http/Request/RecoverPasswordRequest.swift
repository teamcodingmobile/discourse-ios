//
//  RecoverPasswordRequest.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import Foundation

struct RecoverPasswordRequest: HttpRequest {
    typealias Response = RecoverPasswordResponse
    
    var data: RecoverPasswordForm
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/session/forgot_password.json"
    }
    
    var body: [String : Any] {
        return [
            "login": data.username
        ]
    }
}
