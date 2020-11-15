//
//  PostTopicRequest.swift
//  discourse
//
//  Created by Sonia Sieiro on 01/11/2020.
//

import Foundation

struct CreateTopicRequest: HttpRequest {
    typealias Response = CreateTopicResponse
    
    var data: CreateTopicForm
    
    init(withData data: CreateTopicForm) {
        self.data = data
    }
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/posts.json"
    }
    
    var body: [String : Any] {
        return [
            "title": data.title!,
            "raw": data.title!
        ]
    }
    
}

