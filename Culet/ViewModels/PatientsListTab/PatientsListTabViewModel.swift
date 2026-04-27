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
  
  func addPatient() {
    //TODO: Add Patient
    addMockPatient()
  }
  
  func call(patient: Patient, errorManager: ErrorManager) {
    phoneCaller.execute(with: patient, errorManager: errorManager)
  }
  
  // MARK: - Archive
  func toggleArchive(patient: Patient) {
    if isPatientSelected(patient: patient) {
      unselectPatient()
    }

    patient.isArchived.toggle()
  }
  
  // MARK: - DEBUG
  private func addMockPatient() {
    let newPatient = Patient(
      fullName: FullName(firstName: "Юлия", lastName: "Бегемоточук\(Int.random(in: 1..<10000))", middleName: "Андреевна"),
      birthday: Date(timeIntervalSince1970: 1),
      sex: .female,
      phoneNumber: "+7(902)956-55-62"
    )
    storageService.save(patient: newPatient)
  }
}
