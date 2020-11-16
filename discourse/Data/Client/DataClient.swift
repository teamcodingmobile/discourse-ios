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
    func getUser(withId id: Int, onSuccess success: @escaping (User) -> (), onError error: ((Error?) -> ())?) -> Void
    
    func getLatestTopics(atPage page: Int, onSuccess success: @escaping ([TopicItem]) -> (), onError error: ((Error?) -> ())?) -> Void
    
    func getUserTopics(username: String, page: Int, onSuccess success: @escaping ([TopicItem]) -> (), onError error: ((Error?) -> ())?) -> Void
    
    func createTopic(withData data: CreateTopicForm, onSuccess success: @escaping () -> (), onError error: ((Error?) -> ())?) -> Void

    func login(withData data: LoginForm, onSuccess success: @escaping() -> (), onError error: ((Error?)-> ())?) -> Void
    
    func registerUser(withData data: RegisterUserForm, onSuccess success: @escaping () -> (), onError error: ((Error?) -> ())?) -> Void
    
    func recoverPassword(withData data: RecoverPasswordForm, onSuccess success: @escaping() -> (), onError error: ((Error?)-> ())?) -> Void

    func search(byTerm word: String, onSuccess success: @escaping (SearchResult) -> (), onError error: ((Error?) -> ())?) -> Void
}
