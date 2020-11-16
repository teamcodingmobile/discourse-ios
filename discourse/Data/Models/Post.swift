//
//  Post.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 11/11/2020.
//

import Foundation
struct Post{
    var id: Int
    var username: String
    var avatarTemplate: String
    var blurb: String
    
    func getAvatarUrl(size: Int) -> String {
        return avatarTemplate.replacingOccurrences(of: "{size}", with: String(size))
    }
}

extension Post: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
