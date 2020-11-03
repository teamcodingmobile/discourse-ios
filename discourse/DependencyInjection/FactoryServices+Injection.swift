//
//  FactoryServices+Injection.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 31/10/2020.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerFactoryServices() {
        register { PosterFactory() }
        register { TopicItemFactory(posterFactory: resolve()) }
        register { LoginFactory()}
    }
}
