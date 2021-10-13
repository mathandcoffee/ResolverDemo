//
//  ContentViewModel.swift
//  ResolverDemo
//
//  Created by Bryan Malumphy on 10/13/21.
//

import Foundation
import SwiftUI
import Combine
import Resolver

class ContentViewModel {
    @Injected var environment: Environment
    @Published var showingAlert = false
    
    private var environmentSubscription: AnyCancellable?
    
    private var taps = 0
    
    func subscribe() {
        guard environmentSubscription == nil else { return }
        environmentSubscription = environment.environmentDidChange.sink(receiveValue: { environmentType in
            if environmentType == .development {
                self.showingAlert = true
            }
        })
    }
    
    func incrementDeveloperSettingsOption() {
        guard taps < 10 else { return }
        taps += 1
        if taps == 10 {
            environment.environmentType = .development
        }
    }
}
