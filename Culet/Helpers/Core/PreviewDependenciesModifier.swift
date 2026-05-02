//

import SwiftUI
import SwiftData

struct PreviewDependenciesModifier: ViewModifier {
  @State private var modelContainer = PreviewContainer.container
  @State private var errorManager = ErrorManager()
  @State private var appCoordinator = AppCoordinator()
  @State private var userPreferences = {
    let userPreferences = UserPreferences()
    userPreferences.reduceBackgroundAnimations = true
    return userPreferences
  }()
  @State private var appSession = {
    let appSession = AppSession()
    appSession.patientWorkspaceState = .viewing(Patient(fullName: FullName(firstName: "First", lastName: "Last"), sex: .female))
    return appSession
  }()
    
  func body(content: Content) -> some View {
    content
      .modelContainer(modelContainer)
      .environment(errorManager)
      .environment(appCoordinator)
      .environment(userPreferences)
      .environment(appSession)
      .tint(.brand)
  }
}

extension View {
  func withPreviewDependencies() -> some View {
    self.modifier(PreviewDependenciesModifier())
  }
}
