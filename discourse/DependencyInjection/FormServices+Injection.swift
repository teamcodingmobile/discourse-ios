//
//  FormServices+Injection.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 11/11/2020.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerFormServices() {
        register { FormValidator() }
    }
}
