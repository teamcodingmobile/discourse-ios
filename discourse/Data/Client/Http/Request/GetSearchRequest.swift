//
//  GetSearchRequest.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 08/11/2020.
//

import Foundation

struct GetSearchRequest: HttpRequest{
    typealias Response = GetSearchResponse
    var term: String = ""
    
    init(withWord word: String) {
        term = word
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
