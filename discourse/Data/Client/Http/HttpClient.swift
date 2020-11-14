//
//  HttpClient.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 29/10/2020.
//

import Foundation
import UIKit
import Resolver

enum HttpClientError: Error, Equatable {
    case unauthorized
    case serverError
}

final class HttpClient: DataClient {
    
    
    var baseUrl: URL
    
    var apiKey: String
    
    var userLogged: String = "system"
    
    @Injected var authService: AuthService
    
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
    
    func createTopic(withTitle title: String, onSuccess success: @escaping () -> (), onError error: ((Error?) -> ())?) {
        send(request: CreateTopicRequest(withTitle: title), onSuccess: { (_) in
            success()
        }, onError: error)
    }

    func login(withData data: LoginForm, onSuccess success: @escaping () -> (), onError error: ((Error?) -> ())?) {
        send(request: LoginRequest(data: data), onSuccess: { [weak self] response in
            if self != nil {
                self?.authService.logIn(user: data.username!)
                success()
            }
        }, onError: error)
    }
    
    func registerUser(withData data: RegisterUserForm, onSuccess success: @escaping () -> (), onError error: ((Error?) -> ())?) {
        send(request: RegisterUserRequest(data: data), onSuccess: { _ in
            success()
        }, onError: error)
    }

    func getSearch(withTerm word: String, onSuccess success: @escaping (SearchResponse) -> (), onError error: ((Error?) -> ())?) ->Void {
        send(request: GetSearchRequest(withTerm: word), onSuccess: { [weak self ] response in
            if self != nil {
                success(response!)
            }
        }, onError: error)
    }
    
    func recoverPassword(withData data: RecoverPasswordForm, onSuccess success: @escaping() -> (), onError error: ((Error?)-> ())?) -> Void {
        send(request: RecoverPasswordRequest(data: data), onSuccess: { _ in
            success()
        }, onError: error)

    }
    
    private func send<T: HttpRequest>(request: T, onSuccess success: @escaping (T.Response?) -> (), onError failure: ((Error?) -> ())?) {
        let urlRequest = request.build(withBaseUrl: baseUrl, usingApiKey: apiKey, usingApiUsername: authService.loggedUser ?? "system")
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("Unable to cast response to \(HTTPURLResponse.self)")
            }
            
            let statusCode = httpResponse.statusCode
            
            if statusCode >= 500 {
                DispatchQueue.main.async {
                    failure?(HttpClientError.serverError)
                }
                
                return
            }
            
            if statusCode == 403 {
                DispatchQueue.main.async {
                    failure?(HttpClientError.unauthorized)
                }
                
                return
            }
            
            if statusCode >= 400 {
                let errors = try? JSONDecoder().decode(ErrorResponse.self, from: data!).errors
                
                DispatchQueue.main.async {
                    failure?(DataError.invalidData(errors: errors ?? []))
                }
                
                return
            }
            
            let model = try? JSONDecoder().decode(T.Response.self, from: data!)
            
            DispatchQueue.main.async {
                success(model)
            }
        }
        
        task.resume()
    }
    
}
