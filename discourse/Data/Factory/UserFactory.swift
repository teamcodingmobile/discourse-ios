//
//  UserFactory.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 16/11/2020.
//

import Foundation

class UserFactory {
    func create(from response: GetUserResponse?) -> User? {
        guard let response = response else { return nil }
        
        return User(
            id: response.id,
            username: response.username,
            name: response.name,
            avatarUrl: "https://mdiscourse.keepcoding.io" + response.avatarTemplate,
            topicsCount: response.topicsCount,
            postsCount: response.postsCount,
            likesCount: response.likesCount
        )
    }
}
