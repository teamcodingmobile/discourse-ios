//
//  Poster.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 31/10/2020.
//

import Foundation

struct Poster: Codable {
    var id: Int
    var username: String
    var avatarUrl: String
    
    func getAvatarUrl(size: Int) -> String {
        return avatarUrl.replacingOccurrences(of: "{size}", with: String(size))
    }
}
