//
//  GetUserResponse.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation

struct GetUserResponse: Codable {
    var id: Int
    var username: String
    var name: String
    var topicsCount: Int
    var postsCount: Int
    var likesCount: Int
    var avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case topicsCount = "topic_count"
        case postsCount = "post_count"
        case likesCount = "like_count"
        case avatarTemplate = "avatar_template"
    }
}
