//
//  HttpRequest.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 29/10/2020.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol HttpRequest {
    associatedtype Response: Codable
    var method: Method { get }
    var path: String { get }
    var parameters: [String:String] { get }
    var body: [String: Any] { get }
    var headers: [String: String] { get }
}

extension HttpRequest {
    var parameters: [String: String] {
        return [:]
    }
    
    var body: [String: Any] {
        return [:]
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    func build(withBaseUrl baseUrl: URL, usingApiKey apiKey: String) -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        if !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let finalUrl = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        var urlRequest = URLRequest(url: finalUrl)
        
        urlRequest.httpMethod = method.rawValue
        
        if !body.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            urlRequest.httpBody = jsonData
        }
        
        let authService = AuthService()
        let userLoged = authService.log.value(forKey: "user") as? String ?? "system"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(apiKey, forHTTPHeaderField: "Api-Key")
        urlRequest.addValue(userLoged, forHTTPHeaderField: "Api-Username")
        
        return urlRequest
    }
}
