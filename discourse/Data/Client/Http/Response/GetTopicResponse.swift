//
//  GetTopicResponse.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation

struct GetTopicResponse: Codable {
    var id: Int
    var title: String
    var postsCount: Int
    var replyCount: Int
    var viewsCount: Int
    var createdAt: String
    var pinned: Bool
    var details: GetTopicResponseDetails
    var postStream: GetTopicResponsePostStream
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case viewsCount = "views"
        case createdAt = "created_at"
        case pinned
        case details
        case postStream = "post_stream"
    }
}

struct GetTopicResponsePostStream: Codable {
    var posts: [GetTopicResponsePost]
}

struct GetTopicResponsePost: Codable {
    var id: Int
    var username: String
    var avatarTemplate: String
    var createdAt: String
    var cooked: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatarTemplate = "avatar_template"
        case createdAt = "created_at"
        case cooked
    }
}

struct GetTopicResponseDetails: Codable {
    var creator: GetTopicResponseCreator
    
    enum CodingKeys: String, CodingKey {
        case creator = "created_by"
    }
}

struct GetTopicResponseCreator: Codable {
    var id: Int
    var username: String
    var avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatarTemplate = "avatar_template"
    }
}
