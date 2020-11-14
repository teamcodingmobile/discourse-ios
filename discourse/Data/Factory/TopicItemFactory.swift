//
//  TopicItemFactory.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 31/10/2020.
//

import Foundation
import Resolver

class TopicItemFactory {
    @LazyInjected var posterFactory: PosterFactory
    
    init(posterFactory: PosterFactory) {
        self.posterFactory = posterFactory
    }
    
    func create(from response: GetLatestTopicsResponse?) -> [TopicItem] {
        guard let response = response else {
            return []
        }
        
        return response.topics.map { (responseTopic) -> TopicItem in
            let user = response.users.first { (responseUser) -> Bool in
                return responseTopic.lastPosterUsername == responseUser.username
            }
            
            let date = String(responseTopic.lastPostedAt.prefix(10)).toDate()
            let lastPoster = (user != nil) ? posterFactory.create(from: user!) : nil
            
            let topicItem = TopicItem(
                id: responseTopic.id,
                title: responseTopic.title,
                viewsCount: responseTopic.viewsCount,
                postCount: responseTopic.postsCount,
                replyCount: responseTopic.replyCount,
                lastPoster: lastPoster,
                lastPostedAt: date,
                pinned: responseTopic.pinned
            )
            
            return topicItem
        }
    }
}
