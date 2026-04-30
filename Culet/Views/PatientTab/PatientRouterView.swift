//

import SwiftUI

struct PatientRouterView: View {
  @Environment(AppSession.self) private var appSession
  @Environment(UserPreferences.self) private var userPreferences
  
  var body: some View {
    ZStack {
      if userPreferences.reduceBackgroundAnimations {
        MainBackgroundView(isAnimationReduced: true)
      } else {
        MainBackgroundView()
      }
      
      switch appSession.patientWorkspaceState {
      case .empty:
        EmptyPatientWorkspaceView()
      case .creating:
        // TODO: Creating Patient View
        PatientFormView()
      case .viewing(let patient), .editing(let patient):
        // TODO: Patient View
        Text("Viewing \(patient.creationDate)")
      }
    }
  }
}

#Preview {
  PatientRouterView()
    .withPreviewDependencies()
}
