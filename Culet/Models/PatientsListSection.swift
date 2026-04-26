//
//  PatientsListSection.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation

struct PatientsListSection {
  let id = UUID()
  let period: TimePeriod
  var patients: [Patient]
}
