//
//  PatientsListTabView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 25.04.2026.
//

import SwiftUI
import SwiftData

struct PatientsListTabView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(AppCoordinator.self) private var appCoordinator
  @Environment(AppSession.self) private var appSession
  
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
              appSession.patientWorkspaceState = .creating
              appCoordinator.activeTab = .patient
            }
          }
          ToolbarItem(placement: .automatic) {
            Menu("Меню", systemImage: "ellipsis") {
              // MARK: Open Archive Button
              NavigationLink(destination: {
                ArchivedPatientsListView(isAbbreviated: viewModel.isAbbreviated)
              }, label: {
                Label("Архив", systemImage: "archivebox")
              })
              
              // MARK: Lastname Visibilty Toggle
              Toggle("Скрыть фамилии", systemImage: "eye.slash", isOn: $viewModel.isAbbreviated.animation(.snappy))
            }
          }
        }
    }
  }
}

#Preview {
  PatientsListTabView()
    .withPreviewDependencies()
}
