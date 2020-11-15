//
//  GetTopicRequest.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation

struct GetTopicRequest: HttpRequest {
    typealias Response = GetTopicResponse
    
    let id: Int
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/t/\(id).json"
    }
}
