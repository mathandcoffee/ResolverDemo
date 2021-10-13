//
//  ContentView.swift
//  ResolverDemo
//
//  Created by Bryan Malumphy on 10/13/21.
//

import SwiftUI
import Resolver

struct ContentView: View {
    @State var viewModel = ContentViewModel()
    
    init() {
        viewModel.subscribe()
    }
    
    var body: some View {
        Text("Tap for Developer Options")
            .padding()
            .gesture(
                TapGesture()
                    .onEnded {
                        print("Tapped")
                        viewModel.incrementDeveloperSettingsOption()
                    }
            )
            .alert(
                isPresented: $viewModel.showingAlert,
                content: {
                    Alert(
                        title: Text("You are now in Developer Mode"),
                        message: nil,
                        dismissButton: .default(
                            Text("OK"),
                            action: {
                                viewModel.showingAlert = false
                            }
                        )
                    )
                }
            )
        Button(
            "Swap Cameras",
            action: {
                viewModel.swapCameras()
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
