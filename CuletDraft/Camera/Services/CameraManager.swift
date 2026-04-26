//

import Foundation
import AVFoundation

actor CameraManager: CameraManaging {
  private let session: AVCaptureSession
  private let photoOutput: AVCapturePhotoOutput
  
  init(session: AVCaptureSession, photoOutput: AVCapturePhotoOutput) {
    self.session = session
    self.photoOutput = photoOutput
  }
  
  func start() {
    guard !session.isRunning else { return }
    session.startRunning()
  }
  
  func stop() {
    guard session.isRunning else { return }
    session.stopRunning()
  }
  
  func getSession() -> AVCaptureSession {
    return session
  }
}
