//

import Foundation
import os

@Observable
final class PatientFormViewModel {
  var patientLastname = ""
  var patientFirstname = ""
  var patientMiddlename = ""
  var patientSex: Sex = .male
  var patientBirthday: Date = Date()
  var patientPhone = ""
  
  var isPatientLastnameValid: Bool {
    checkValid(name: patientLastname)
  }
  var isPatientFirstnameValid: Bool {
    checkValid(name: patientFirstname)
  }
  var isPatientMiddlenameValid: Bool {
    if patientMiddlename.isEmpty {
      return true
    }
    return checkValid(name: patientMiddlename)
  }
  
  var selectedPatient: Patient?
  var editMode: Bool {
    selectedPatient != nil
  }
  
  init(patient: Patient?) {
    guard let patient else {
      return
    }
    
    self.patientLastname = patient.fullName.lastName
    self.patientFirstname = patient.fullName.firstName
    self.patientMiddlename = patient.fullName.middleName ?? ""
    self.patientSex = patient.sex
    self.patientBirthday = patient.birthday ?? Date()
    self.patientPhone = patient.phoneNumber ?? ""
    
    self.selectedPatient = patient
  }
  
  func saveButton(appCoordinator: AppCoordinator, appSession: AppSession, errorManager: ErrorManageService) {
    if editMode {
      guard let selectedPatient else {
        Logger.ui.error("No patient has been selected")
        return
      }
      if isAllValid() {
        enterPatientData(patient: selectedPatient, errorManager: errorManager)
      } else {
        // TODO: Alert
      }
    } else {
      
    }
  }
  
  func cancelButton(appCoordinator: AppCoordinator, appSession: AppSession) {
    if editMode {
      // TODO: Cancel Action when Edit Mode is Active
    } else {
      // TODO: Must call the alert
      appCoordinator.activeTab = .patientsList
      appSession.patientWorkspaceState = .empty
    }
  }
  
  /// Заполняет свойства `Patient` локальными данными класса
  private func enterPatientData(patient: Patient, errorManager: ErrorManageService) {
    guard let cleanFirstname = FullName.cleanName(name: patientFirstname),
          let cleanLastName = FullName.cleanName(name: patientLastname) else {
      Logger.ui.error("Error writing data to Patient. After trim, the string is nil.")
      errorManager.handle(PatientFormError.nilEnteringAfterTrim)
      return
    }
    let cleanMiddleName = FullName.cleanName(name: patientMiddlename)
    
    patient.fullName.lastName = cleanLastName
    patient.fullName.firstName = cleanFirstname
    patient.fullName.middleName = cleanMiddleName
    patient.sex = self.patientSex
    patient.birthday = self.patientBirthday
    patient.phoneNumber = self.patientPhone
  }
  
  private func checkValid(name: String) -> Bool {
    guard let trimmedText = FullName.cleanName(name: name) else {
      return false
    }
    return FullName.isValidName(name: trimmedText)
  }
  
  /// Проверяет, что все поля валидны
  private func isAllValid() -> Bool {
    let result = isPatientLastnameValid && isPatientFirstnameValid && isPatientMiddlenameValid
    return result
  }
}
