//
//  DataManager.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import SwiftData

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
