//
//  PatientsListView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI
import SwiftData

struct PatientsListView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(ErrorManager.self) private var errorManager
  @Environment(AppCoordinator.self) private var appCoordinator
  @Environment(AppSession.self) private var appSession
  
  @Query(
    filter: #Predicate<Patient> { !$0.isArchived },
    sort: \Patient.creationDate,
    order: .reverse
  )
  private var patients: [Patient]
  
  @Bindable var viewModel: PatientsListTabViewModel
  
  private let swipesDelay = 250
  
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
                isAbbreviated: viewModel.isAbbreviated,
                isSelected: viewModel.isPatientSelected(patient: patient)
              )
              
              // MARK: - On Tap Gesture
              .contentShape(Rectangle())
              .onTapGesture {
                withAnimation(.snappy) {
                  viewModel.handleTap(patient: patient)
                  if viewModel.isPatientSelected(patient: patient) {
                    appSession.patientWorkspaceState = .active(patient)
                  } else {
                    appSession.patientWorkspaceState = .empty
                  }
                }
              }
              
              // MARK: - Context Menu
              .contextMenu {
                // MARK: Call Patient Button
                PhoneCallButton(
                  phoneNumber: patient.phoneNumber,
                  isAbbreviated: viewModel.isAbbreviated,
                  action: { viewModel.call(patient: patient, errorManager: errorManager) }
                )
                
                // MARK: Archive Patient Button
                Button(
                  action: {
                    if viewModel.isPatientSelected(patient: patient) {
                      appSession.patientWorkspaceState = .empty
                    }
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
                    if viewModel.isPatientSelected(patient: patient) {
                      appSession.patientWorkspaceState = .empty
                    }
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
                    if viewModel.isPatientSelected(patient: patient) {
                      appSession.patientWorkspaceState = .empty
                    }
                    
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
              // MARK: Swipe that Opens Archive
              .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(
                  role: .destructive,
                  action: {
                    if viewModel.isPatientSelected(patient: patient) {
                      appSession.patientWorkspaceState = .empty
                    }
                    
                    Task {
                      try? await Task.sleep(for: .milliseconds(swipesDelay))
                      viewModel.toggleArchive(patient: patient)
                    }
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
