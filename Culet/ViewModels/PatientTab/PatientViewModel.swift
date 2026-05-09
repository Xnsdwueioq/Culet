//

import Foundation

@Observable
final class PatientViewModel {
  var phoneCaller: CallPatientUseCase
  
  var patient: Patient
  
  // MARK: - Patient Data
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
