//
//  DataManager.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import SwiftData

protocol PatientStorageService: Sendable {
  func save(patient: Patient)
  func delete(patient: Patient)
}

final class DataManager: PatientStorageService {
  private let modelContext: ModelContext
  
  init(modelContext: ModelContext = AppDatabase.shared.context) {
    self.modelContext = modelContext
  }
  
  func save(patient: Patient) {
    modelContext.insert(patient)
  }
  
  func delete(patient: Patient) {
    modelContext.delete(patient)
  }
}
