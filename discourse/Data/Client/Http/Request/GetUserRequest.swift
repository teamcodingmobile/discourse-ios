//
//  GetUserRequest.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation

struct GetUserRequest: HttpRequest {
    typealias Response = GetUserResponse
    
    let id: Int
    
    init(userId id: Int) {
        self.id = id
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/admin/users/\(id).json"
    }
    
    var headers: [String : String] {
        return [
            "Api-Username": "system"
        ]
    }
}
