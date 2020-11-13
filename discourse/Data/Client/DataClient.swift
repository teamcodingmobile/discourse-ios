//
//  Client.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 29/10/2020.
//

import Foundation

enum DataError: Error, Equatable {
    case invalidData(errors: [String])
}

protocol DataClient {
    func getLatestTopics(atPage page: Int, onSuccess success: @escaping ([TopicItem]) -> (), onError error: ((Error?) -> ())?) -> Void
    
    func createTopic(withTitle title: String, onSuccess success: @escaping () -> (), onError error: ((Error?) -> ())?) -> Void

    func login(withUser username: String, onSuccess success: @escaping() -> (), onError error: ((Error?)-> ())?) -> Void
    
    func registerUser(withData data: RegisterUserForm, onSuccess success: @escaping () -> (), onError error: ((Error?) -> ())?) -> Void
}
