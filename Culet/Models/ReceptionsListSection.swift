//
//  ReceptionsListSection.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 09.05.2026.
//

import Foundation
import SwiftData

struct ReceptionsListSection: Identifiable {
  var id: PersistentIdentifier
  var date: Date
  var metrics: [ReceptionMetric]
  var notes: String
}
