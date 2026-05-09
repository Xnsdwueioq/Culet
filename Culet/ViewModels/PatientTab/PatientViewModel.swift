//

import Foundation
import SwiftData

@Observable
final class PatientViewModel {
  var phoneCaller: CallPatientUseCase
  
  var patient: Patient
  
  var receptions: [ReceptionsListSection] {
    guard let receptions = patient.receptions else {
      return []
    }
    
    return receptions
      .sorted { $0.date > $1.date }
      .compactMap { reception in
        let metrics: [ReceptionMetric] = reception.bodyProportionMetrics.map { .bodyProportion($0) }
        let lastDate = reception.bodyProportionMetrics.max(by: { $0.measuredAt > $1.measuredAt })?.measuredAt
        return ReceptionsListSection(
          id: reception.id,
          date: lastDate ?? reception.date,
          metrics: metrics,
          notes: reception.notes
        )
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
  
  // MARK: - Toolbar Actions
  func editPatient(appSession: AppSession) {
    appSession.patientWorkspaceState = .editing(patient)
  }
  
  func callPatient(errorManager: ErrorManageService) async {
    await phoneCaller.execute(with: patient, errorManager: errorManager)
  }
}
