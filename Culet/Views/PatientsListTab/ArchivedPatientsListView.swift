//
//  ArchivedPatientsListView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI
import SwiftData

struct ArchivedPatientsListView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(
    filter: #Predicate<Patient> { $0.isArchived },
    sort: \Patient.creationDate,
    order: .reverse
  )
  private var patients: [Patient]
  @State private var viewModel = PatientsListTabViewModel()
  
  var isLastNameInvisible: Bool
  
  var body: some View {
    Group {
      if viewModel.patients.isEmpty {
        List {
          PatientsListEmptyView()
        }
      } else {
        List(viewModel.groupedPatients) { section in
          Section(section.period.rawValue) {
            ForEach(section.patients) { patient in
              PatientListRowView(
                patient: patient,
                isAbbreviated: isLastNameInvisible,
                isSelected: false
              )
              .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button(
                  role: .destructive,
                  action: {
                    // TODO: Delete Patient
                  },
                  label: { Image(systemName: "trash") }
                )
              }
              .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(
                  role: .destructive,
                  action: {
                    viewModel.toggleArchive(patient: patient)
                  },
                  label: {
                    Image(systemName: "person.crop.rectangle.stack")
                      .tint(.cyan)
                  }
                )
              }
            }
          }
        }
        .searchable(
          text: $viewModel.searchableText,
          prompt: "Введите имя"
        )
      }
    }
    .navigationTitle("Архив")
    .onChange(of: patients, initial: true) { _, newPatients in
      viewModel.patients = newPatients
    }
  }
}

#Preview {
  ArchivedPatientsListView(isLastNameInvisible: false)
    .modelContainer(PreviewContainer.container)
}
