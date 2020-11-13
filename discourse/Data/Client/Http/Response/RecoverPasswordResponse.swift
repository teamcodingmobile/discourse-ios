//
//  RecoverPasswordResponse.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import Foundation

struct RecoverPasswordResponse: Codable {
    var result: String
    var userFound: Bool
    
    enum CodingKeys: String, CodingKey {
        case result
        case userFound = "user_found"
    }
}
