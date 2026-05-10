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
    appSession.patientWorkspaceState = .viewing(PreviewDependenciesModifier.testPatient)
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

extension PreviewDependenciesModifier {
  /// Returns test `Patient` instance
  static var testPatient: Patient {
    let danil = Patient(
      fullName: FullName(firstName: "Данил", lastName: "Самкраскин", middleName: "Федорович"),
      birthday: Date(timeIntervalSince1970: 60*60*24*365*46),
      sex: .male,
      phoneNumber: "123-123-234",
      creationDate: Date().advanced(by: -60*60*24*80)
    )
    let rec1 = Reception(
      date: Calendar.current.date(byAdding: .day, value: -30, to: .now)!,
      notes: ""
    )
    rec1.patient = danil
    rec1.bodyProportionMetrics.append(BodyProportionMetric(measuredAt: rec1.date))
    
    let rec2 = Reception(
      date: Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
      notes: "Повторный прием после курса упражнений."
    )
    rec2.patient = danil
    rec2.bodyProportionMetrics.append(BodyProportionMetric(measuredAt: rec2.date))
    rec2.bodyProportionMetrics.append(BodyProportionMetric(measuredAt: rec2.date.advanced(by: 60*60)))
    rec2.bodyProportionMetrics.append(BodyProportionMetric(measuredAt: rec2.date.advanced(by: 60*60*2)))
    rec2.bodyProportionMetrics.append(BodyProportionMetric(measuredAt: rec2.date.advanced(by: 60*60*3)))
    
    return danil
  }
}

extension View {
  func withPreviewDependencies() -> some View {
    self.modifier(PreviewDependenciesModifier())
  }
}
