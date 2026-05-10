//
//  ReceptionView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 10.05.2026.
//

import SwiftUI

struct ReceptionView: View {
  var viewModel: PatientViewModel
  var reception: Reception
  
  var body: some View {
    VStack(spacing: 5) {
      // MARK: - Last Metric Date
      HStack {
        Text(reception.displayDate.formatted(date: .numeric, time: .shortened))
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
            ForEach(reception.receptionMetrics) { metric in
              Button(action: { viewModel.selectMetric(metric) } ) {
                MetricPreview(metric: metric)
              }
              .sensoryFeedback(.selection, trigger: viewModel.viewingMetric)
              .buttonStyle(.plain)
            }
          }
          .padding()
        }
        
        if !reception.notes.isEmpty{
          Divider()
          
          // MARK: Notes
          NotesPreview(notes: reception.notes)
            .foregroundStyle(.secondary)
            .padding()
        }
      }
      .glassEffect(.clear, in: .rect(cornerRadius: 25))
      
      // MARK: - Context Menu
      .contentShape(.rect)
      .contextMenu {
        NavigationLink(destination: {
          NotesView(notes: Binding(
            get: {
              reception.notes
            }, set: {
              reception.notes = $0
            }
          ))
        }) {
          Label("Заметки", systemImage: "pencil")
        }
      }
    }
  }
}
