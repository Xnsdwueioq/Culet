//

import Foundation

@Observable
final class PatientViewModel {
  var phoneCaller: CallPatientUseCase
  
  var patient: Patient
  
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
