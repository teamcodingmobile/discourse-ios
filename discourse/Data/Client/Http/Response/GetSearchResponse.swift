//
//  GetSearchResponse.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 08/11/2020.
//

import Foundation
struct GetSearchResponse: Codable{
    var posts: [GetSearchPostsResponse]?
    var topics: [GetLatestTopicsResponseTopic]?
    var users: [GetLatestTopicsResponseUser]?
}

struct GetSearchPostsResponse: Codable {
    var id: Int?
    var username: String?
    var avatarUrl: String?
    var blurb: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatarUrl = "avatar_template"
        case blurb
    }
    
}
