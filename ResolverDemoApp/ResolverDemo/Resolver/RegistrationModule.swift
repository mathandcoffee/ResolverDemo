//
//  RegistrationModule.swift
//  ResolverDemo
//
//  Created by Bryan Malumphy on 10/13/21.
//

import Foundation

protocol RegistrationModule {
    static func register()
}

extension RegistrationModule {
    init() { fatalError("You Should Never Initialize a Module") }
}
