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
  @Environment(ErrorManager.self) private var errorManager
  @Query(
    filter: #Predicate<Patient> { $0.isArchived },
    sort: \Patient.creationDate,
    order: .reverse
  )
  private var patients: [Patient]
  @State private var viewModel = PatientsListTabViewModel()
  
  var isLastNameInvisible: Bool
  
  private let swipesDelay = 250
  
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
              let phoneNumber = patient.phoneNumber
              
              PatientListRowView(
                patient: patient,
                isAbbreviated: isLastNameInvisible,
                isSelected: false
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
                    Text(phoneNumber ?? "")
                  }
                )
                .disabled(phoneNumber == nil)
                
                // MARK: Unarchive Patient Button
                Button(
                  action: {
                    viewModel.toggleArchive(patient: patient)
                  },
                  label: {
                    Label("В активные", systemImage: "person.crop.rectangle.stack")
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
                      .tint(.red)
                  }
                )
              }
              
              // MARK: - Swipe Actions
              // MARK: Swipe that Deletes Patient
              .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button(
                  role: .destructive,
                  action: {
                    Task {
                      try? await Task.sleep(for: .milliseconds(swipesDelay))
                      viewModel.deletePatient(patient: patient)
                    }
                  },
                  label: {
                    Image(systemName: "trash")
                      .tint(.red)
                  }
                )
              }
              
              // MARK: Swipe that Archives Patient
              .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(
                  role: .destructive,
                  action: {
                    Task {
                      try? await Task.sleep(for: .milliseconds(swipesDelay))
                      viewModel.toggleArchive(patient: patient)
                    }
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
