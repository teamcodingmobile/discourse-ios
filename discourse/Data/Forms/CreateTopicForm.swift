//
//  CreateTopicForm.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation

class CreateTopicForm: Form {
    var title: String?
    
    init(title: String?) {
        self.title = title
    }
    
    var fields: [FormField] {
        return [
            FormField(name: "title", value: title, constraints: [.isRequired, .isGreaterThan(15)])
        ]
    }
}
