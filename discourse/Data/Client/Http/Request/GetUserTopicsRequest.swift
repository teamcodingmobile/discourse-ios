//
//  GetUserTopicsRequest.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation

struct GetUserTopicsRequest: HttpRequest {
    typealias Response = GetUserTopicsResponse
    
    let username: String
    let page: Int
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/topics/created-by/\(username).json"
    }
    
    var parameters: [String : String] {
        return [
            "page": String(page)
        ]
    }
}
