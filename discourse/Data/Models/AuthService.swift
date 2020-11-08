//
//  AuthService.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 08/11/2020.
//

import Foundation

struct AuthService {
    
    let log = UserDefaults.standard
    
    func logIn(user: String){
        log.setValue(user, forKey: "log")
    }
    
    func logOut(){
        log.removeObject(forKey: "log")
    }
    
}
