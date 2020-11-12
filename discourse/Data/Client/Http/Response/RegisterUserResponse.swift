//
//  RegisterUserResponse.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 07/11/2020.
//

import Foundation

struct RegisterUserResponse: Codable {
    var success: Bool
    var active: Bool
    var message: String
    var userId: Int
    
    enum CodingKeys: String, CodingKey {
        case success
        case active
        case message
        case userId = "user_id"
    }
}
