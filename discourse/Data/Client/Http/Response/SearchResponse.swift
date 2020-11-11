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

struct SearchTopicsResponse: Codable {
    var id: Int?
    var title: String?
    var postsCount: Int?
    var lastPostedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case lastPostedAt = "last_posted_at"
    
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        postsCount = try values.decode(Int.self, forKey: .postsCount)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        
        let lastPostedAtString = try values.decode(String.self, forKey: .lastPostedAt)
        lastPostedAt = dateFormatter.date(from: lastPostedAtString)

    }
}

struct SearchUsersResponse: Codable{
    var id : Int?
    var name: String?
    var username: String?
    var avatarTemplate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case avatarTemplate = "avatar_template"
        
    }
    
}
