//
//  PostItem.swift
//  discourse
//
//  Created by Sonia Sieiro on 01/11/2020.
//

import Foundation

struct PostItem {
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
}

