//
//  AuthService.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 08/11/2020.
//

import Foundation

struct AuthService {
    
    fileprivate static let log = UserDefaults.standard
    
    func logIn(user: String){
        AuthService.log.setValue(user, forKey: "log")
    }
    
    func logOut(){
        AuthService.log.removeObject(forKey: "log")
    }
    
}
