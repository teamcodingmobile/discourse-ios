//
//  PostError.swift
//  discourse
//
//  Created by Sonia Sieiro on 01/11/2020.
//

import Foundation

struct PostError: Error {
    var action: String
    var errors: [String]
}
