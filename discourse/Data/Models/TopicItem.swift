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
    var viewsCount: Int?
    var postCount: Int
    var replyCount: Int
    var lastPoster: Poster?
    var lastPostedAt: Date?
    var excerpt: String?
    var pinned: Bool
}

extension TopicItem: Equatable {
    static func == (lhs: TopicItem, rhs: TopicItem) -> Bool {
        return lhs.id == rhs.id
    }
}
