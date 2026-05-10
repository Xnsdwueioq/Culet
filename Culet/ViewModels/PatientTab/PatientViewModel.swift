//

import Foundation
import SwiftData

@Observable
final class PatientViewModel {
  var phoneCaller: CallPatientUseCase

  var patient: Patient
  
  // MARK: - Receptions & Metrics Logic
  var receptions: [Reception] {
    (patient.receptions ?? []).sorted { $0.date > $1.date }
  }
  
  var metricWorkspaceState = MetricWorkspaceState.empty
  
  /// An item for destination, returns `ReceptionMetric`, if `metricWorkspaceState` contains it
  var viewingMetric: ReceptionMetric? {
    get {
      if case .viewing(let metric) = metricWorkspaceState {
        return metric
      }
      return nil
    }
    
    set {
      metricWorkspaceState = newValue.map { .viewing($0) } ?? .empty
    }
  }
  
  // MARK: - Patient Profile Info
  var fullName: FullName { patient.fullName }
  var firstName: String { fullName.firstName }
  var lastName: String { fullName.lastName }
  var middleName: String? { fullName.middleName }
  var sex: String {
    switch patient.sex {
    case .male: "Мужчина"
    case .female: "Женщина"
    }
  }
  var birthday: String? { patient.birthday?.formatted(date: .numeric, time: .omitted) }
  var age: String? { patient.getAge()?.yearsString }
  var phoneNumber: String? { patient.phoneNumber }
  var notes: String { patient.notes }
  var creationDate: String { patient.creationDate.formatted(date: .numeric, time: .shortened) }
  
  init(patient: Patient, phoneCaller: CallPatientUseCase = CallPatientUseCase()) {
    self.patient = patient
    self.phoneCaller = phoneCaller
  }
  
  // MARK: - Receptions & Metrics Logic
  
  // TODO: DEBUG func, will be replaced by navigation link with value-based pattern
  func createMetric(metric type: Metric) {
    switch type {
    case .bodyProportion:
      print("CREATE BODY PROPORTION METRIC")
    }
  }
  
  func selectMetric(_ metric: ReceptionMetric) {
    metricWorkspaceState = .viewing(metric)
  }
  
  // MARK: - Toolbar Actions
  func editPatient(appSession: AppSession) {
    appSession.patientWorkspaceState = .editing(patient)
  }
  
  func callPatient(errorManager: ErrorManageService) async {
    await phoneCaller.execute(with: patient, errorManager: errorManager)
  }
}
