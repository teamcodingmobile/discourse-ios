//
//  UserItemViewModel.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/20.
//

import Foundation
class UserItemViewModel{
    let user: Poster
    
    init(user: Poster) {
        
        self.user = user
        
        let id = user.id
        let poster = user.username
        let avatarUrl = user.avatarUrl
    }
}
