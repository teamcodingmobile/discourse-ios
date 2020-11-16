//
//  PostFactory.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 15/11/20.
//

import Foundation

class PostFactory {
    func create(from response: [SearchPostsResponse]?) -> [Post] {
        guard let response = response else { return [] }
        
        return response.map{ (responsePost) -> Post in
            
            let posterItem = Post(
                id: responsePost.id,
                username: responsePost.username,
                avatarTemplate: "https://mdiscourse.keepcoding.io" + responsePost.avatarUrl,
                blurb: responsePost.blurb)
            
            return posterItem
        }
    }
}
