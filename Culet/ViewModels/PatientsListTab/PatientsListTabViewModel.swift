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
  private let patientGroupingService: PatientGroupingService
  
  var isLastNameInvisible: Bool = false
  var searchableText: String = ""
  
  var patients: [Patient] = []
  var groupedPatients: [PatientsListSection] {
    guard !searchableText.isEmpty else {
      return patientGroupingService.group(patients: patients)
    }
    
    let query = searchableText.lowercased()
    
    // Patients Filtering
    let filteredPatients = patients.filter { patient in
      let fullName = patient.fullName
      let fullNameString = "\(fullName.firstName) \(fullName.lastName) \(fullName.middleName ?? "")".lowercased()
      let condition = fullNameString.contains(query)
      
      return condition
    }
    
    return patientGroupingService.group(patients: filteredPatients)
  }
  
  init(patientGroupingService: PatientGroupingService = PatientGroupingService()) {
    self.patientGroupingService = patientGroupingService
  }
  
  // MARK: - Patient Control
  func deletePatient(patient: Patient, modelContext: ModelContext) {
    Task {
      let debounce = 250
      try? await Task.sleep(for: .milliseconds(debounce))
      
      await MainActor.run {
        modelContext.delete(patient)
      }
    }
  }
  
  // MARK: - Toolbar Functions
  func addPatient(modelContext: ModelContext) {
    //TODO: Add Patient
    addMockPatient(modelContext: modelContext)
  }
  
  func toggleArchive(patient: Patient) {
    Task {
      let debounce = 250
      try? await Task.sleep(for: .milliseconds(debounce))
      
      await MainActor.run {
        patient.isArchived.toggle()
      }
    }
  }
  
  // MARK: - DEBUG
  private func addMockPatient(modelContext: ModelContext) {
    let newPatient = Patient(
      fullName: FullName(firstName: "Иван", lastName: "Иванов\(Int.random(in: 1..<10000))", middleName: "Иванович"),
      birthday: Date(timeIntervalSince1970: 1),
      sex: .male,
      mobileNumber: "+7 (999) 123-45-67"
    )
    modelContext.insert(newPatient)
  }
}
