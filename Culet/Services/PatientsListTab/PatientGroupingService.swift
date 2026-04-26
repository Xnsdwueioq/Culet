//
//  PatientGroupingService.swift
//  Drafts
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation

final class PatientGroupingService {
  func group(patients: [Patient], relativeTo now: Date = Date()) -> [PatientsListSection] {
    let now = Date()
    
    let groupedDictionary = Dictionary(grouping: patients) { $0.creationDate.timePeriod(relativeTo: now) }
    return TimePeriod.allCases.compactMap { period in
      guard let patientsInSection = groupedDictionary[period] else { return nil }
      return PatientsListSection(period: period, patients: patientsInSection)
    }
  }
}
