//
//  TopicItem.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 29/10/2020.
//

import Foundation

struct TopicItem {
    var id: Int
    var title: String
    var postCount: Int
    var replyCount: Int
    var lastPoster: Poster?
    var lastPostedAt: Date?
    var excerpt: String?
    var pinned: Bool
}
