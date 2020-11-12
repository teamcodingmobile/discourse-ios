//
//  GetLoginRequest.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 03/11/2020.
//

import Foundation

struct LoginRequest: HttpRequest {
    
    typealias Response = LoginResponse
    var user: String
    
    init(username: String) {
        user = username
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/users/\(user).json"
    }
    
    var parameters: [String : String] {
        return ["":""]
    }
    
    var headers: [String : String]{
        return ["Api-Username": user]
    }
}
