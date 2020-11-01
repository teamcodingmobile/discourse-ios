//
//  PostErrorFactory.swift
//  discourse
//
//  Created by Sonia Sieiro on 01/11/2020.
//

import Foundation

class PostErrorFactory {
    func create(from response: PostTopicErrorResponse) -> PostError {
        return PostError(
            action: response.action,
            errors: response.errors
        )
    }
}
