//
//  PostFactory.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 15/11/20.
//

import Foundation

class PostFactory {
    private static let avatarBaseUrl = "https://mdiscourse.keepcoding.io"
    
    func create(from response: [SearchPostsResponse]?) -> [Post] {
        guard let response = response else { return [] }
        
        return response.map{ (responsePost) -> Post in
            
            return Post(
                id: responsePost.id,
                username: responsePost.username,
                avatarTemplate: PostFactory.avatarBaseUrl + responsePost.avatarUrl,
                blurb: responsePost.blurb,
                createdAt: responsePost.createdAt.toDate()
            )
        }
    }
    
    func create(from response: [GetTopicResponsePost]) -> [Post] {
        return response.map { post in
            return Post(
                id: post.id,
                username: post.username,
                avatarTemplate: PostFactory.avatarBaseUrl + post.avatarTemplate,
                blurb: post.cooked.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil),
                createdAt: post.createdAt.toDate()
            )
        }
    }
}
