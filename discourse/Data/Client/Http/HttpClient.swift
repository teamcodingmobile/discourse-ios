//
//  HttpClient.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 29/10/2020.
//

import Foundation
import UIKit
import Resolver

enum HttpClientError: Error {
    case statusCode(Int)
}

final class HttpClient: DataClient {
    var baseUrl: URL
    
    var apiKey: String
    
    @Injected var topicItemFactory: TopicItemFactory
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        return session
    }()
    
    init(withBaseUrl url: String, apiKey key: String) {
        guard let url = URL(string: url) else {
            fatalError("$(url) is not a valid URL")
        }
        
        baseUrl = url
        apiKey = key
    }
    
    func getLatestTopics(atPage page: Int, onSuccess success: @escaping ([TopicItem]) -> (), onError error: ((Error?) -> ())?) -> Void {
        send(request: GetLatestTopicsRequest(atPage: page), onSuccess: { [weak self] response in
            if self != nil {
                success(self!.topicItemFactory.create(from: response))
            }
        }, onError: error)
    }
    
    private func send<T: HttpRequest>(request: T, onSuccess success: @escaping (T.Response?) -> (), onError failure: ((Error?) -> ())?) {
        let urlRequest = request.build(withBaseUrl: baseUrl, usingApiKey: apiKey)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
                DispatchQueue.main.async {
                    failure?(HttpClientError.statusCode(httpResponse.statusCode))
                }
                return
            }
            
            if let data = data, data.count > 0 {
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        success(model)
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure?(error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    success(nil)
                }
            }
        }
        
        task.resume()
    }
}
