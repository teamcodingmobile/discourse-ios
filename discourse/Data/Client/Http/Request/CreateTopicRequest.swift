//
//  PostTopicRequest.swift
//  discourse
//
//  Created by Sonia Sieiro on 01/11/2020.
//

import Foundation

struct CreateTopicRequest: HttpRequest {
    typealias Response = CreateTopicResponse
    
    var title: String
    
    init(withTitle title: String) {
        self.title = title
    }
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/posts.json"
    }
    
    var body: [String : Any] {
        return [
            "title": title,
            "raw": title
        ]
    }
    
}
