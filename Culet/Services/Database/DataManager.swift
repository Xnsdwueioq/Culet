//
//  DataManager.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import SwiftData
import os

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
  
  func deleteAll() throws {
    do {
      try modelContext.delete(model: Patient.self)
    } catch {
      Logger.database.error("Delete all patients failed.")
      throw DatabaseError.deleteAllError
    }
  }
}
