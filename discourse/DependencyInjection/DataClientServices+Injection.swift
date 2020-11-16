//
//  DataClientServices+Injection.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 31/10/2020.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerDataClientServices() {
        register { AuthService() }
        register {
            HttpClient(
                withBaseUrl: "https://mdiscourse.keepcoding.io",
                apiKey: "699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a"
            )
        }.implements(DataClient.self)
    }
}
