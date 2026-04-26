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
  
  let viewModel: PatientsListTabViewModel
  
  var body: some View {
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
    .onChange(of: patients, initial: true) { _, newPatients in
      viewModel.updateGroupedPatients(patients: newPatients)
    }
  }
}

#Preview {
  PatientsListTabView()
    .modelContainer(PreviewContainer.container)
}
