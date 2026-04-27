//
//  AppDatabase.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import SwiftData
import os

final class AppDatabase {
  static let shared = AppDatabase()
  
  let container: ModelContainer
  let context: ModelContext
    
  private init() {
    let schema = Schema([Patient.self, Reception.self])
    let config = ModelConfiguration(isStoredInMemoryOnly: false)
    
    do {
      container = try ModelContainer(for: schema, configurations: config)
      context = container.mainContext
    } catch {
      Logger.database.critical("Could not initialize SwiftData")
      fatalError("Could not initialize SwiftData: \(error)")
    }
  }
}
