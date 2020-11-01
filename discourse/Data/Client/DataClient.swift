//
//  Client.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 29/10/2020.
//

import Foundation

protocol DataClient {
    func getLatestTopics(atPage page: Int, onSuccess success: @escaping ([TopicItem]) -> (), onError error: ((Error?) -> ())?) -> Void
    func postTopic(withTitle title: String, onSuccess success: @escaping (PostItem) -> (), onError error: ((Error?) -> ())?) -> Void
}
