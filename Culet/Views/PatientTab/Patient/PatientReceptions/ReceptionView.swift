//
//  ReceptionView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 10.05.2026.
//

import SwiftUI

struct ReceptionView: View {
  var reception: ReceptionsListSection
  
  var body: some View {
    VStack {
      // MARK: - Header of Reception View
      Text(reception.date.formatted(date: .numeric, time: .shortened))
        .bold()
      Text(reception.notes)
        .foregroundStyle(.secondary)
      
      // MARK: - Metrics List
      ForEach(reception.metrics) { metric in
        MetricView(metric: metric)
      }
    }
    .padding()
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}
