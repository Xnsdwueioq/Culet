//
//  ReceptionView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 10.05.2026.
//

import SwiftUI

struct ReceptionView: View {
  var viewModel: PatientViewModel
  var reception: ReceptionsListSection
  
  var body: some View {
    VStack(spacing: 5) {
      // MARK: - Last Metric Date
      HStack {
        Text(reception.date.formatted(date: .numeric, time: .shortened))
          .bold()
          .foregroundStyle(.secondary)
        Spacer()
      }
      .padding(.horizontal)
      
      // MARK: - Section
      VStack(alignment: .leading, spacing: 0) {
        // MARK: Metrics List
        ScrollView(.horizontal) {
          HStack {
            ForEach(reception.metrics) { metric in
              Button(action: { viewModel.selectMetric(metric) } ) {
                MetricPreview(metric: metric)
              }
              .buttonStyle(.plain)
            }
          }
          .padding()
        }
        
        if !reception.notes.isEmpty{
          Divider()
          
          // MARK: Notes
          Text(reception.notes)
            .foregroundStyle(.secondary)
            .padding()
        }
      }
      .glassEffect(.clear, in: .rect(cornerRadius: 25))
    }
  }
}
