//
//  PatientStorageService.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import SwiftData

protocol PatientStorageService: Sendable {
  func save(patient: Patient)
  func delete(patient: Patient)
}
