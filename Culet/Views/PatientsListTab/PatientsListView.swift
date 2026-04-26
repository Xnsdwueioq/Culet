//
//  PatientsListView.swift
//  VisionDraft
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI
import SwiftData

struct PatientsListView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Patient.creationDate, order: .reverse) private var patients: [Patient]
  
  @Bindable var viewModel: PatientsListTabViewModel
  
  var body: some View {
    Group {
      if viewModel.patients.isEmpty {
        List {
          PatientsListEmptyView(addPatientAction: {
            viewModel.addPatient(modelContext: modelContext)
          })
        }
      } else {
        List(viewModel.groupedPatients) { section in
          Section(section.period.rawValue) {
            ForEach(section.patients) { patient in
              PatientListRowView(
                patient: patient,
                isAbbreviated: viewModel.isLastNameInvisible,
                isSelected: true
              )
            }
          }
        }
        .searchable(
          text: $viewModel.searchableText,
          prompt: "Введите имя"
        )
      }
    }
    .onChange(of: patients, initial: true) { _, newPatients in
      viewModel.patients = newPatients
    }
  }
}

#Preview {
  PatientsListTabView()
    .modelContainer(PreviewContainer.emptyContainer)
}
