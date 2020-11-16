//
//  AuthService.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 08/11/2020.
//

import Foundation

protocol AuthServicesProtocol{
    
    var isLogged: Bool { get }
    var loggedUser: String? { get }
    
    func logIn(id: Int, username: String)
    func logOut()
}

class AuthService: AuthServicesProtocol{
    
    private static let userId = "loggedUserId"
    private static let username = "loggedUser"
    
    private let storage = UserDefaults.standard
    
    var isLogged: Bool {
        get {
            return storage.value(forKey: AuthService.username) != nil
        }
    }
    
    var loggedUser: String? {
        get {
            return storage.string(forKey: AuthService.username)
        }
    }
    
    var loggedUserId: Int? {
        get {
            return storage.integer(forKey: AuthService.userId)
        }
    }
    
    func logIn(id: Int, username: String){
        storage.setValue(id, forKey: AuthService.userId)
        storage.setValue(username, forKey: AuthService.username)
    }
    
    func logOut(){
        storage.removeObject(forKey: AuthService.username)
    }
    
}
