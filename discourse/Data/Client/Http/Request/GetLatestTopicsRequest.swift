//
//  GetLatestTopicsRequest.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 29/10/2020.
//

import Foundation

struct GetLatestTopicsRequest: HttpRequest {
    typealias Response = GetLatestTopicsResponse
    var page: Int
    
    init(atPage pageNumber: Int) {
        page = pageNumber
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/latest.json"
    }
    
    var parameters: [String : String] {
        return ["page": String(page)]
    }
}
