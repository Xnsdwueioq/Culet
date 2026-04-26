//

import Foundation
import AVFoundation

actor CameraConfigurator: CameraConfigurating {
  enum ConfigError: Error {
    case deviceUnavailable
    case cannotAddInput
    case cannotAddOutput
  }
  
  func configure() throws -> (AVCaptureSession, AVCapturePhotoOutput) {
    let session = AVCaptureSession()
    
    session.beginConfiguration()
    
    defer {
      session.commitConfiguration()
    }
    
    session.sessionPreset = .high
    
    // MARK: - Video Device
    guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
      throw ConfigError.deviceUnavailable
    }
    
    // MARK: - Device Input
    let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
    guard session.canAddInput(videoDeviceInput) else {
      throw ConfigError.cannotAddInput
    }
    session.addInput(videoDeviceInput)
    
    // MARK: - Device Output
    let photoOutput = AVCapturePhotoOutput()
    guard session.canAddOutput(photoOutput) else {
      throw ConfigError.cannotAddOutput
    }
    session.addOutput(photoOutput)
    
    
    return (session, photoOutput)
  }
}

