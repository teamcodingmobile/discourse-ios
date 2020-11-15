//
//  PostItemViewModel.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/20.
//

import Foundation

class PostItemViewModel{
    let post: Post
    
    init(post: Post) {
        
        self.post = post
        
        let id = post.id
        let poster = post.username
        let blurb = post.blurb
    }
}
