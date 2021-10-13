//
//  VideoCapture.swift
//  ResolverDemo
//
//  Created by Bryan Malumphy on 10/13/21.
//

import Foundation
import AVFoundation
import Combine

enum CameraChangeError: Error {
    case cameraCouldNotSwapToBack
    case cameraCouldNotSwapToFront
}

protocol VideoCapture {
    var camerasDidSwap: AnyPublisher<AVCaptureDevice.Position, CameraChangeError> { get }
    func swapCameras()
}
