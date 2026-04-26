//

import SwiftUI

struct CameraView: View {
  @State private var viewModel = CameraViewModel()
  
  var body: some View {
    ZStack {
      if let session = viewModel.session {
        CameraPreviewView(session: session)
          .ignoresSafeArea()
      } else {
        ProgressView()
      }
    }
    .task {
      viewModel.prepareCamera()
    }
    .onAppear {
      viewModel.onAppear()
    }
    .onDisappear {
      viewModel.onDisappear()
    }
  }
}
