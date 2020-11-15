//
//  PosterFactory.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 31/10/2020.
//

import Foundation

class PosterFactory {
    func create(from response: GetLatestTopicsResponseUser) -> Poster {
        return Poster(
            id: response.id,
            username: response.username,
            avatarUrl: "https://mdiscourse.keepcoding.io" + response.avatarTemplate
        )
    }
    
    func createSearch(from response: [SearchUsersResponse]?) -> [Poster] {
        guard let response = response else { return [] }
        
        return response.map{ (responseTopic) -> Poster in
            
            let posterItem = Poster(
                id: responseTopic.id,
                name: responseTopic.name,
                username: responseTopic.username,
                avatarUrl: "https://mdiscourse.keepcoding.io" + responseTopic.avatarTemplate
            )
            
            return posterItem
        }
    }
}
