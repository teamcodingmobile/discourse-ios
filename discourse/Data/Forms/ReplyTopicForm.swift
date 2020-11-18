//
//  ReplyTopicForm.swift
//  discourse
//
//  Created by Sonia Sieiro on 17/11/2020.
//

import Foundation

class ReplyTopicForm: Form {
    var id: Int?
    var title: String?
    
    init(id: Int?, title: String?) {
        self.id = id
        self.title = title
        
    }
    
    var fields: [FormField] {
        return [
            FormField(name: "title", value: title, constraints: [.isRequired])
        ]
    }
}
