//
//  AppDelegate+Injection.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 31/10/2020.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerFactoryServices()
        registerDataClientServices()
    }
}
