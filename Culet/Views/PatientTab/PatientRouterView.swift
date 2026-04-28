//

import SwiftUI

struct PatientRouterView: View {
  @Environment(AppSession.self) private var appSession
  @Environment(UserPreferences.self) private var userPreferences
  
  var body: some View {
    ZStack {
      MainBackgroundView(isAnimationReduced: userPreferences.reduceBackgroundAnimations)
      
      switch appSession.patientWorkspaceState {
      case .empty:
        EmptyPatientWorkspaceView()
      case .creating:
        // TODO: Creating Patient View
        Text("Creating")
      case.active(let patient):
        // TODO: Patient View
        Text("Creating \(patient.creationDate)")
      }
    }
  }
}

#Preview {
  PatientRouterView()
    .withPreviewDependencies()
}
