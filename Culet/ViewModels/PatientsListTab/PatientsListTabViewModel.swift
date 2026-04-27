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

  var isLastNameInvisible: Bool = false
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
  
  init(
    patientStorageService: PatientStorageService = DataManager(),
    patientGroupingService: PatientGroupingService = PatientGroupingService(),
    phoneCaller: CallPatientUseCase = CallPatientUseCase()
  ) {
    self.storageService = patientStorageService
    self.groupingService = patientGroupingService
    self.phoneCaller = phoneCaller
  }
  
  // MARK: - Patient Controls
  func deletePatient(patient: Patient) {
    Task {
      let delay = 250
      try? await Task.sleep(for: .milliseconds(delay))
      
      await MainActor.run {
        storageService.delete(patient: patient)
      }
    }
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
    Task {
      let delay = 250
      try? await Task.sleep(for: .milliseconds(delay))
      
      await MainActor.run {
        patient.isArchived.toggle()
      }
    }
  }
  
  // MARK: - DEBUG
  private func addMockPatient() {
    let newPatient = Patient(
      fullName: FullName(firstName: "Иван", lastName: "Иванов\(Int.random(in: 1..<10000))", middleName: "Иванович"),
      birthday: Date(timeIntervalSince1970: 1),
      sex: .male,
      phoneNumber: "+7 (999) 123-45-67"
    )
    storageService.save(patient: newPatient)
  }
}
