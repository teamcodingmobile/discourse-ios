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
    var viewsCount: Int
    var postsCount: Int
    var replyCount: Int
    var lastPoster: Poster?
    var lastPostedAt: String
    var excerpt: String?
    var pinned: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case viewsCount = "views_count"
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case lastPoster = "last_poster"
        case lastPostedAt = "last_posted_at"
        case excerpt
        case pinned
    }

}

struct SearchUsersResponse: Codable{
    var id : Int
    var username: String
    var avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatarTemplate = "avatar_template"
        
    }
    
}
