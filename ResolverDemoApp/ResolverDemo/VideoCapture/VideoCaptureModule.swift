//
//  VideoCaptureModule.swift
//  ResolverDemo
//
//  Created by Bryan Malumphy on 10/13/21.
//

import Foundation
import Resolver
import Combine
import AVFoundation

fileprivate class VideoCaptureImpl: VideoCapture {
    
    var currentCameraPosition: AVCaptureDevice.Position = .front {
        didSet {
            if currentCameraPosition != oldValue {
                _camerasDidSwap.send(currentCameraPosition)
                print("Did Change Camera Position: \(currentCameraPosition)")
            } else {
                fatalError("Cannot try to swap cameras to the same one!")
            }
        }
    }
    
    lazy var _camerasDidSwap: CurrentValueSubject<AVCaptureDevice.Position, CameraChangeError> = {
        CurrentValueSubject<AVCaptureDevice.Position, CameraChangeError>(currentCameraPosition)
    }()
    
    var camerasDidSwap: AnyPublisher<AVCaptureDevice.Position, CameraChangeError> {
        _camerasDidSwap.eraseToAnyPublisher()
    }
    
    func swapCameras() {
        if currentCameraPosition == .front {
            currentCameraPosition = .back
        } else {
            currentCameraPosition = .front
        }
    }
}

struct VideoCaptureModule: RegistrationModule {
    
    private init() { fatalError("You Should Never Initialize a Module") }
    
    static func register() {
        Resolver.register {
            VideoCaptureImpl() as VideoCapture
        }.scope(.shared)
    }
}
