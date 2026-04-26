//

import SwiftUI
import AVFoundation

struct CameraPreviewView: UIViewRepresentable {
  let session: AVCaptureSession
  let gravity: AVLayerVideoGravity = .resizeAspect
  
  func makeUIView(context: Context) -> CameraPreviewUIView {
    let view = CameraPreviewUIView(session: session, gravity: gravity)
    view.backgroundColor = .black
    
    return view
  }
  
  func updateUIView(_ uiView: CameraPreviewUIView, context: Context) {
    if uiView.videoPreviewLayer.session != session {
      uiView.videoPreviewLayer.session = session
    }
  }
}
