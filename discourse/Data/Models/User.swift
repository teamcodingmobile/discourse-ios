//
//  User.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation

struct User {
    let id: Int
    let username: String
    let name: String
    let avatarUrl: String
    let topicsCount: Int
    let postsCount: Int
    let likesCount: Int
    
    func getAvatarUrl(size: Int) -> String {
        return avatarUrl.replacingOccurrences(of: "{size}", with: String(size))
    }
}
