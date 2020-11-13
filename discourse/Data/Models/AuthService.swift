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
    
    func logIn(user: String)
    func logOut()
}

class AuthService: AuthServicesProtocol{
    
    private static let userKey = "loggedUser"
    
    private let storage = UserDefaults.standard
    
    var isLogged: Bool {
        get {
            return storage.value(forKey: AuthService.userKey) != nil
        }
    }
    
    var loggedUser: String? {
        get {
            return storage.string(forKey: AuthService.userKey)
        }
    }
    
    func logIn(user: String){
        storage.setValue(user, forKey: AuthService.userKey)
    }
    
    func logOut(){
        storage.removeObject(forKey: AuthService.userKey)
    }
    
}
