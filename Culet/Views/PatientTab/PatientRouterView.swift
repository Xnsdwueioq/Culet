//

import SwiftUI

struct PatientRouterView: View {
  @Environment(AppSession.self) private var appSession
  
  var body: some View {
    ZStack {
      MainBackgroundView()
      
      switch appSession.patientWorkspaceState {
      case .empty:
        // TODO: Placeholder for Empty State
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
