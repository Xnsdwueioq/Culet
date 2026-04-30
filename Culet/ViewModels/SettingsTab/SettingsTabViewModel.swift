//
//  SettingsTabViewModel.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 01.05.2026.
//

import Foundation

@Observable
final class SettingsTabViewModel {
  private var storageService: PatientStorageService
  
  var activeAlert: SettingsAlert?
  
  init(storageService: PatientStorageService = DataManager(), activeAlert: SettingsAlert? = nil) {
    self.storageService = storageService
    self.activeAlert = activeAlert
  }
  
  func deleteButton() {
    activeAlert = .deleteAll
  }
  
  func deleteAll(errorManager: ErrorManageService) {
    do {
      try storageService.deleteAll()
    } catch {
      errorManager.handle(error)
    }
  }
}
