//

import UIKit
import AVFoundation

class CameraPreviewUIView: UIView {
  override class var layerClass: AnyClass {
    AVCaptureVideoPreviewLayer.self
  }
  
  var videoPreviewLayer: AVCaptureVideoPreviewLayer {
    return layer as! AVCaptureVideoPreviewLayer
  }
  
  init(session: AVCaptureSession, gravity: AVLayerVideoGravity) {
    super.init(frame: .zero)
    videoPreviewLayer.session = session
    videoPreviewLayer.videoGravity = gravity
    
    self.setContentHuggingPriority(.defaultLow, for: .horizontal)
    self.setContentHuggingPriority(.defaultLow, for: .vertical)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
