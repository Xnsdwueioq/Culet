//

import Foundation

@Observable
final class PatientViewModel {
  var phoneCaller: CallPatientUseCase
  
  var patient: Patient
  
  // MARK: - Patient Name
  var fullName: FullName { patient.fullName }
  var firstName: String { fullName.firstName }
  var lastName: String { fullName.lastName }
  var middleName: String? { fullName.middleName }
  
  init(patient: Patient, phoneCaller: CallPatientUseCase = CallPatientUseCase()) {
    self.patient = patient
    self.phoneCaller = phoneCaller
  }
  
  
  // MARK: - Toolbar Actions
  func editPatient(appSession: AppSession) {
    appSession.patientWorkspaceState = .editing(patient)
  }
  
  func callPatient(errorManager: ErrorManageService) {
    phoneCaller.execute(with: patient, errorManager: errorManager)
  }
}
