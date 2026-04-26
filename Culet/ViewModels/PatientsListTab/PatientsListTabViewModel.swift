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
  var isLastNameInvisible: Bool = false
  
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
      fullName: FullName(firstName: "Иван\(Int.random(in: 1..<10000))", lastName: "Иванов", middleName: "Иванович"),
      birthday: Date(),
      sex: .male,
      mobileNumber: "+7 (999) 123-45-67"
    )
    modelContext.insert(newPatient)
  }
}
