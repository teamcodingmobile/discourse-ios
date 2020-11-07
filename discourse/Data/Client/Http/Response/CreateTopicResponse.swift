//
//  PostTopicResponse.swift
//  discourse
//
//  Created by Sonia Sieiro on 01/11/2020.
//

import Foundation


struct CreateTopicResponse: Codable {
    var id: Int
    var name: String?
    var username: String
    var avatarTemplate: String
    var createdAt: String
    var cooked: String
    var postNumber: Int
    var updatedAt: String
    var replyCount: Int
    var canEdit: Bool

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case avatarTemplate = "avatar_template"
        case createdAt = "created_at"
        case cooked
        case postNumber = "post_number"
        case updatedAt = "updated_at"
        case replyCount = "reply_count"
        case canEdit = "can_edit"
    }
}


struct PostTopicErrorResponse: Codable {
    var action: String
    var errors: [String]
}
