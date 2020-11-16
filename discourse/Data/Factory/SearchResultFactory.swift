//
//  SearchResultFactory.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 16/11/2020.
//

import Foundation

class SearchResultFactory {
    let posterFactory: PosterFactory
    let postFactory: PostFactory
    
    init(postFactory: PostFactory, posterFactory: PosterFactory) {
        self.postFactory = postFactory
        self.posterFactory = posterFactory
    }
    
    func create(from response: SearchResponse?) -> SearchResult {
        guard let response = response else { return SearchResult() }
        
        let posts = postFactory.create(from: response.posts)
        let users = posterFactory.create(from: response.users)
        
        return SearchResult(
            posts: posts,
            users: users
        )
    }
}
