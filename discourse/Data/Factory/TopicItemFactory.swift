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
            
            let date = responseTopic.lastPostedAt.toDate()
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
    
    func create(from response: GetUserTopicsResponse?) -> [TopicItem] {
        guard let response = response else {
            return []
        }
        
        return response.topicList.topics.map { (responseTopic) -> TopicItem in
            let user = response.users.first { (responseUser) -> Bool in
                return responseTopic.posters[0].userId == responseUser.id
            }
            
            let date = responseTopic.createdAt.toDate()
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
