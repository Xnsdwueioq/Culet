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
  @Environment(ErrorManager.self) private var errorManager
  @Query(
    filter: #Predicate<Patient> { !$0.isArchived },
    sort: \Patient.creationDate,
    order: .reverse
  )
  private var patients: [Patient]
  
  @Bindable var viewModel: PatientsListTabViewModel
  
  var body: some View {
    Group {
      if viewModel.patients.isEmpty {
        List {
          PatientsListEmptyView(addPatientAction: {
            viewModel.addPatient()
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
              // MARK: - Context Menu
              .contextMenu {
                // MARK: Call Patient Button
                Button(
                  action: {
                    viewModel.call(patient: patient, errorManager: errorManager)
                  },
                  label: {
                    Label("Позвонить", systemImage: "phone")
                    Text(patient.phoneNumber ?? "")
                  }
                )
                
                // MARK: Archive Patient Button
                Button(
                  action: {
                    viewModel.toggleArchive(patient: patient)
                  },
                  label: {
                    Label("В архив", systemImage: "archivebox")
                  }
                )
                
                // MARK: Delete Patient Button
                Button(
                  role: .destructive,
                  action: {
                    viewModel.deletePatient(patient: patient)
                  },
                  label: {
                    Label("Удалить", systemImage: "trash")
                  }
                )
              }
              
              // MARK: - Swipe Actions
              // MARK: Swipe that Deletes Patient
              .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button(
                  role: .destructive,
                  action: {
                    viewModel.deletePatient(patient: patient)
                  },
                  label: { Image(systemName: "trash") }
                )
              }
              // MARK: Swipe that Opens Archive
              .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(
                  role: .destructive,
                  action: {
                    viewModel.toggleArchive(patient: patient)
                  },
                  label: {
                    Image(systemName: "archivebox")
                      .tint(.gray)
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
    .onChange(of: patients, initial: true) { _, newPatients in
      viewModel.patients = newPatients
    }
  }
}

#Preview {
  PatientsListTabView()
    .environment(ErrorManager())
    .environment(AppCoordinator())
    .environment(AppSession())
    .modelContainer(PreviewContainer.container)
}
