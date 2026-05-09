//
//  ReceptionsListSection.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 09.05.2026.
//

import Foundation

struct ReceptionsListSection: Identifiable {
  var date: Date
  var metrics: [ReceptionMetric]
  
  var id = UUID()
}
