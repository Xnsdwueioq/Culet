//
//  PatientsListTabViewModel.swift
//  Drafts
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation
import SwiftData

@Observable
final class PatientsListTabViewModel {
  private let storageService: PatientStorageService
  private let groupingService: PatientGroupingService
  private let phoneCaller: CallPatientUseCase
  
  var isAbbreviated: Bool = false
  var searchableText: String = ""
  
  var patients: [Patient] = []
  var groupedPatients: [PatientsListSection] {
    guard !searchableText.isEmpty else {
      return groupingService.group(patients: patients)
    }
    
    let query = searchableText.lowercased()
    
    // Patients Filtering
    let filteredPatients = patients.filter { patient in
      let fullName = patient.fullName
      let fullNameString = "\(fullName.firstName) \(fullName.lastName) \(fullName.middleName ?? "")".lowercased()
      let condition = fullNameString.contains(query)
      
      return condition
    }
    
    return groupingService.group(patients: filteredPatients)
  }
  
  var selectedPatient: Patient?
  
  init(
    patientStorageService: PatientStorageService = DataManager(),
    patientGroupingService: PatientGroupingService = PatientGroupingService(),
    phoneCaller: CallPatientUseCase = CallPatientUseCase()
  ) {
    self.storageService = patientStorageService
    self.groupingService = patientGroupingService
    self.phoneCaller = phoneCaller
    
  }
  
  // MARK: - Patient Selecting
  func isPatientSelected(patient: Patient) -> Bool {
    self.selectedPatient?.id == patient.id
  }
  
  func handleTap(patient: Patient) {
    if isPatientSelected(patient: patient) {
      unselectPatient()
    } else {
      selectPatient(patient: patient)
    }
  }
  
  func onAppearPatientSelection(appSession: AppSession) {
    switch appSession.patientWorkspaceState {
    case .viewing(let patient), .editing(let patient):
      selectPatient(patient: patient)
      
    default:
      selectedPatient = nil
    }
  }
  
  private func selectPatient(patient: Patient) {
    self.selectedPatient = patient
  }
  
  private func unselectPatient() {
    self.selectedPatient = nil
  }
  
  // MARK: - Patient Controls
  func deletePatient(patient: Patient) {
    if isPatientSelected(patient: patient) {
      unselectPatient()
    }
    
    storageService.delete(patient: patient)
  }
  
  func addPatient(appSession: AppSession, appCoordinator: AppCoordinator) {
    appSession.patientWorkspaceState = .creating
    appCoordinator.activeTab = .patient
  }
  
  func call(patient: Patient, errorManager: ErrorManageService) async {
    await phoneCaller.execute(with: patient, errorManager: errorManager)
  }
  
  // MARK: - Archive
  func toggleArchive(patient: Patient) {
    if isPatientSelected(patient: patient) {
      unselectPatient()
    }
    
    patient.isArchived.toggle()
  }
}
