//
//  EnvironmentServiceModule.swift
//  ResolverDemo
//
//  Created by Bryan Malumphy on 10/13/21.
//

import Foundation
import Combine
import Resolver


fileprivate class EnvironmentImpl: Environment {
    
    init(buildType: BuildType) {
        self.buildType = buildType

        environmentType = buildType == .debug ? .development : .production
    }
    
    var environmentType: EnvironmentType = .production {
        didSet {
            if environmentType != oldValue {
                _environmentDidChange.send(environmentType)
                print("Changed Environment Type to: \(environmentType)")
            }
        }
    }
    var buildType: BuildType
    
    private lazy var _environmentDidChange: CurrentValueSubject<EnvironmentType, Never> = {
        CurrentValueSubject<EnvironmentType, Never>(environmentType)
    }()

    var environmentDidChange: AnyPublisher<EnvironmentType, Never> {
        _environmentDidChange.eraseToAnyPublisher()
    }
}

struct EnvironmentServiceModule: RegistrationModule {
    static func register() {
        #if DEBUG
        let isDebug = true
        #else
        let isDebug = false
        #endif

        let buildType: BuildType = isDebug ? .debug : .release
        Resolver.register {
            EnvironmentImpl(buildType: buildType) as Environment
        }.scope(.cached)
    }
}