//
//  GetLoginRequest.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 03/11/2020.
//

import Foundation

struct GetLoginRequest: HttpRequest {
    
    typealias Response = GetLoginResponse
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
