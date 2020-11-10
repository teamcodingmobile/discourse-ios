//
//  AuthService.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 08/11/2020.
//

import Foundation

protocol AuthServicesProtocol{
    func logIn(user: String)
    func logOut()
}

class AuthService: AuthServicesProtocol{
    
    private let log = UserDefaults.standard
    
    var userLogged = "system"
    var isLogged: Bool
    
    init(){
        if (log.value(forKey: "log") != nil){
            isLogged = true
        }else {
            isLogged = false
        }
    }
    
    func logIn(user: String){
        log.setValue(user, forKey: "log")
        userLogged = log.value(forKey: "log") as! String
        isLogged = true
    }
    
    func logOut(){
        log.removeObject(forKey: "log")
        isLogged = false
    }
    
}
