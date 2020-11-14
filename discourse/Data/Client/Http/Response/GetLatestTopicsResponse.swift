//
//  LatestTopicsResponse.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 29/10/2020.
//

import Foundation

struct GetLatestTopicsResponse: Codable {
    var users: [GetLatestTopicsResponseUser]
    var topics: [GetLatestTopicsResponseTopic]
    
    enum CodingKeys: String, CodingKey {
        case users
        case topicList = "topic_list"
    }
    
    enum TopicListKeys: String, CodingKey {
        case topics
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        users = try values.decode([GetLatestTopicsResponseUser].self, forKey: .users)
        let topicList = try values.nestedContainer(keyedBy: TopicListKeys.self, forKey: .topicList)
        topics = try topicList.decode([GetLatestTopicsResponseTopic].self, forKey: .topics)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var topicList = container.nestedContainer(keyedBy: TopicListKeys.self, forKey: .topicList)
        try topicList.encode(topics, forKey: .topics)
    }
}

struct GetLatestTopicsResponseTopic: Codable {
    var id: Int
    var title: String
    var viewsCount: Int
    var postsCount: Int
    var replyCount: Int
    var lastPosterUsername: String
    var lastPostedAt: String
    var excerpt: String?
    var pinned: Bool
    var posters: [TopicPoster]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case viewsCount = "views"
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case lastPostedAt = "last_posted_at"
        case lastPosterUsername = "last_poster_username"
        case excerpt
        case pinned
        case posters
    }
    
    init(from decoder: Decoder) throws {
    
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        viewsCount = try values.decode(Int.self, forKey: .viewsCount)
        postsCount = try values.decode(Int.self, forKey: .postsCount)
        replyCount = try values.decode(Int.self, forKey: .replyCount)
        lastPosterUsername = try values.decode(String.self, forKey: .lastPosterUsername)
        excerpt = (try values.decodeIfPresent(String.self, forKey: .excerpt)) ?? nil
        pinned = try values.decode(Bool.self, forKey: .pinned)
        posters = (try? values.decode([TopicPoster].self, forKey: .posters)) ?? []
        lastPostedAt = try values.decode(String.self, forKey: .lastPostedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct GetLatestTopicsResponseUser: Codable {
    var id: Int
    var username: String
    var avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatarTemplate = "avatar_template"
    }
}

struct TopicPoster: Codable {
    var userId: Int
    var extras: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case extras
        case description
    }
}
