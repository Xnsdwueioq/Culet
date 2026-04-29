//

import Foundation
import os

final class PatientFormViewModel {
  var patientLastname = ""
  var patientFirstname = ""
  var patientMiddlename = ""
  var patientSex: Sex = .male
  var patientBirthday: Date = Date()
  var patientPhone = ""
  
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
  
  func saveButton(appCoordinator: AppCoordinator, appSession: AppSession) {
    if editMode {
      guard let selectedPatient else {
        Logger.ui.error("No patient has been selected")
        return
      }
      enterPatientData(patient: selectedPatient)
      // TODO: Save Action when Edit Mode is Active
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
  private func enterPatientData(patient: Patient) {
    patient.fullName.lastName = self.patientLastname
    patient.fullName.firstName = self.patientFirstname
    patient.fullName.middleName = self.patientMiddlename
    patient.sex = self.patientSex
    patient.birthday = self.patientBirthday
    patient.phoneNumber = self.patientPhone
  }
  
  /// Валидирует полученные из контролов данные,
  /// делает их готовыми для сохранения в модель
  private func validateNewData() {
    // TODO: Implement Validation Logic
    // Maybe will be able to call alert
  }
}
