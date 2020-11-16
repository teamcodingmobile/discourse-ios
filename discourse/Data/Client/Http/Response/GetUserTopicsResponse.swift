//
//  GetUserTopicsResponse.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation

struct GetUserTopicsResponse: Codable {
    var users: [GetUserTopicsResponseUser]
    var topicList: GetUserTopicsResponseTopicList
    
    enum CodingKeys: String, CodingKey {
        case users = "users"
        case topicList = "topic_list"
    }
}

struct GetUserTopicsResponseUser: Codable {
    var id: Int
    var username: String
    var avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatarTemplate = "avatar_template"
    }
}

struct GetUserTopicsResponseTopicList: Codable {
    var topics: [GetUserTopicsResponseTopic]
}

struct GetUserTopicsResponseTopic: Codable {
    var id: Int
    var title: String
    var viewsCount: Int
    var postsCount: Int
    var replyCount: Int
    var pinned: Bool
    var createdAt: String
    var posters: [GetUserTopicsResponsePoster]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case viewsCount = "views"
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case pinned
        case createdAt = "created_at"
        case posters
    }
}

struct GetUserTopicsResponsePoster: Codable {
    var userId: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}
