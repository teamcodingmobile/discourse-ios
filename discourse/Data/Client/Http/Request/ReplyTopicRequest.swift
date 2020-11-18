//
//  ReplyTopicRequest.swift
//  discourse
//
//  Created by Sonia Sieiro on 17/11/2020.
//

import Foundation

struct ReplyTopicRequest: HttpRequest {
    typealias Response = CreateTopicResponse
    
    var data: ReplyTopicForm
    
    init(withData data: ReplyTopicForm) {
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
            "topic_id": data.id!,
            "raw": data.title!
        ]
    }
    
}
