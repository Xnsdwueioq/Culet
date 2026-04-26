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
  var groupedPatients: [PatientsListSection] = []
  
  init(patientGroupingService: PatientGroupingService = PatientGroupingService()) {
    self.patientGroupingService = patientGroupingService
  }
  
  // MARK: - List Logic
  func updateGroupedPatients(patients: [Patient]) {
    self.groupedPatients = patientGroupingService.group(patients: patients)
  }
  
  // MARK: - Toolbar Functions
  func addPatient(modelContext: ModelContext) {
    //TODO: Add Patient
    addMockPatient(modelContext: modelContext)
  }
  
  func openArchive() {
    //TODO: Open Archive
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
