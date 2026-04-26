//
//  PatientsListTabView.swift
//  VisionDraft
//
//  Created by Eyhciurmrn Zmpodackrl on 25.04.2026.
//

import SwiftUI
import SwiftData

struct PatientsListTabView: View {
  @Environment(\.modelContext) private var modelContext
  @State private var viewModel = PatientsListTabViewModel()
  
  var body: some View {
    NavigationStack {
      // MARK: - Patients List
      Group {
        PatientsListView(viewModel: viewModel)
      }
        .navigationTitle(Text("Пациенты"))
      // MARK: - Toolbar
        .toolbar {
          ToolbarItem(placement: .automatic) {
            // MARK: Add Patient Button
            Button("Добавить пациента", systemImage: "plus") {
              viewModel.addPatient(modelContext: modelContext)
            }
          }
          ToolbarItem(placement: .automatic) {
            Menu("Menu", systemImage: "ellipsis") {
              // MARK: Archive Button
              Button("Архив", systemImage: "archivebox") {
                viewModel.openArchive()
              }
              // MARK: Lastname Visibilty Toggle
              Toggle("Скрыть фамилии", systemImage: "eye.slash", isOn: $viewModel.isLastNameInvisible)
            }
          }
        }
    }
  }
}

#Preview {
  PatientsListTabView()
    .modelContainer(for: [Patient.self, Reception.self])
}
