//
//  PosterFactory.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 31/10/2020.
//

import Foundation

class PosterFactory {
    func create(from response: GetLatestTopicsResponseUser) -> Poster {
        return Poster(
            id: response.id,
            username: response.username,
            avatarUrl: "https://mdiscourse.keepcoding.io" + response.avatarTemplate
        )
    }
}
