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

class ContentViewModel: ObservableObject {
    @Injected private var environment: Environment
    @Injected private var videoCapture: VideoCapture
    
    private var environmentSubscription: AnyCancellable?
    
    @Published private(set) var taps = 0
    
    func subscribe() {
        guard environmentSubscription == nil else { return }
        environmentSubscription = environment.environmentDidChange.sink(receiveValue: { environmentType in
            if environmentType == .development {
                print("Developer Options Now Available")
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
    
    func swapCameras() {
        videoCapture.swapCameras()
    }
}
