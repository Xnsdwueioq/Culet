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
        PatientFormView()
      case .viewing(let patient), .editing(let patient):
        PatientView(patient: patient)
      }
    }
  }
}

#Preview {
  PatientRouterView()
    .withPreviewDependencies()
}
