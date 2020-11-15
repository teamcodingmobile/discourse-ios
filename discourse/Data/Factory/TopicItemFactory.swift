//
//  TopicItemFactory.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 31/10/2020.
//

import Foundation
import Resolver

class TopicItemFactory {
    var posterFactory: PosterFactory
    var postFactory: PostFactory
    
    init(posterFactory: PosterFactory, postFactory: PostFactory) {
        self.posterFactory = posterFactory
        self.postFactory = postFactory
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
    
    func create(from response: GetTopicResponse) -> TopicItem {
        let creator = posterFactory.create(from: response.details.creator)
        let posts = postFactory.create(from: response.postStream.posts)
        
        return TopicItem(
            id: response.id,
            title: response.title,
            viewsCount: response.viewsCount,
            postCount: response.postsCount,
            replyCount: response.replyCount,
            author: creator,
            lastPostedAt: response.createdAt.toDate(),
            pinned: response.pinned,
            posts: posts
        )
    }
}
