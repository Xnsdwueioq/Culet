//

import Foundation
import AVFoundation

@Observable
final class CameraViewModel {
  var session: AVCaptureSession?
  
  private var manager: CameraManaging?
  private let configurator: CameraConfigurating
  
  init(
    configurator: CameraConfigurating = CameraConfigurator()
  ) {
    self.configurator = configurator
  }
  
  func onAppear() {
    Task { await manager?.start() }
  }
  
  func onDisappear() {
    Task { await manager?.stop() }
  }
  
  func prepareCamera() {
    Task {
      do {
        let (configuredSession, output) = try await configurator.configure()
        let cameraManager = CameraManager(session: configuredSession, photoOutput: output)
        
        await MainActor.run {
          self.manager = cameraManager
          self.session = configuredSession
        }
        
        await cameraManager.start()
      } catch {
        print("Error: \(error.localizedDescription)")
      }
    }
  }
}
