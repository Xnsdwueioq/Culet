//
//  Reception.swift
//  Drafts
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation
import SwiftData

@Model
final class Reception {
  var date: Date
  var notes: String
  var patient: Patient?
  
  @Relationship(deleteRule: .cascade)
  var bodyProportionMetrics: [BodyProportionMetric] = []
  
  init(date: Date = .now, notes: String = "", bodyProportionMetrics: [BodyProportionMetric] = []) {
    self.date = date
    self.notes = notes
    self.bodyProportionMetrics = bodyProportionMetrics
  }
}

