//
//  EnvironmentService.swift
//  ResolverDemo
//
//  Created by Bryan Malumphy on 10/13/21.
//

import Foundation
import Combine

enum EnvironmentType {
    case development
    case production
}

enum BuildType {
    case debug
    case release
}

protocol Environment {
    var environmentType: EnvironmentType { get set }
    var buildType: BuildType { get }
    var environmentDidChange: AnyPublisher<EnvironmentType, Never> { get }
}
