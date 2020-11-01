//
//  PostItemFactory.swift
//  discourse
//
//  Created by Sonia Sieiro on 01/11/2020.
//

import Foundation

class PostItemFactory {
    func create(from response: PostTopicSuccessResponse) -> PostItem {
        return PostItem(
            id: response.id,
            name: response.name,
            username: response.username,
            avatarTemplate: response.avatarTemplate,
            createdAt: response.createdAt,
            cooked: response.cooked,
            postNumber: response.postNumber,
            updatedAt: response.updatedAt,
            replyCount: response.replyCount,
            canEdit: response.canEdit
        )
    }
}
