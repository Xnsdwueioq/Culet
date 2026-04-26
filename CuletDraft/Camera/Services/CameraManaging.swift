//

import AVFoundation

protocol CameraManaging: Actor {
  func start()
  func stop()
  func getSession() -> AVCaptureSession
}
