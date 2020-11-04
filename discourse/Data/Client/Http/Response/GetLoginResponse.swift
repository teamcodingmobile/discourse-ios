//
//  GetLoginResponse.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 03/11/2020.
//

import Foundation
struct GetLoginResponse: Codable{
    
    var user: UserLogin
}

struct UserLogin: Codable{
    let id: Int
    let username: String
    let name: String
}
