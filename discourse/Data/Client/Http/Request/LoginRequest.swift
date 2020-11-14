//
//  GetLoginRequest.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 03/11/2020.
//

import Foundation

struct LoginRequest: HttpRequest {
    
    typealias Response = LoginResponse
    
    var data: LoginForm
    
    init(data: LoginForm) {
        self.data = data
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/users/\(data.username!).json"
    }
    
    var parameters: [String : String] {
        return ["":""]
    }
    
    var headers: [String : String]{
        return ["Api-Username": data.username!]
    }
}
