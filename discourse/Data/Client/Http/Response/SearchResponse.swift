//
//  GetSearchResponse.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 08/11/2020.
//

import Foundation
struct SearchResponse: Codable{
    var posts: [SearchPostsResponse]? = []
    var topics: [SearchTopicsResponse]? = []
    var users: [SearchUsersResponse]? = []
}

struct SearchPostsResponse: Codable {
    var id: Int
    var username: String
    var avatarUrl: String
    var blurb: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatarUrl = "avatar_template"
        case blurb
    }
    
}

struct SearchTopicsResponse: Codable {
    var id: Int
    var title: String
    var postsCount: Int
    var replyCount: Int
    var lastPostedAt: String
    var pinned: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case lastPostedAt = "last_posted_at"
        case pinned
    }

}

struct SearchUsersResponse: Codable{
    var id : Int
    var name: String
    var username: String
    var avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case avatarTemplate = "avatar_template"
        
    }
    
}
