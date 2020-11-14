//
//  GetSearchRequest.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 08/11/2020.
//

import Foundation

struct GetSearchRequest: HttpRequest{
    typealias Response = SearchResponse
    var term: String = ""
    
    init(withTerm termInput: String) {
        term = termInput
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/search/query.json"
    }
    
    var parameters: [String : String] {
        return ["term": term]
    }
}
