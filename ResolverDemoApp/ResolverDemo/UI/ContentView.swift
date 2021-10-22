//
//  ContentView.swift
//  ResolverDemo
//
//  Created by Bryan Malumphy on 10/13/21.
//

import SwiftUI
import Resolver

struct ContentView: View {
    
    @ObservedObject
    var viewModel = ContentViewModel()
    
    init() {
        viewModel.subscribe()
    }
    
    var tap: some Gesture {
        TapGesture()
            .onEnded {
                viewModel.incrementDeveloperSettingsOption()
            }
    }
    
    var body: some View {
        Text("Tapped \(viewModel.taps) times for Developer Options")
            .gesture(
                tap
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
