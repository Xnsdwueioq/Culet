//
//  TabsView.swift
//  VisionDraft
//
//  Created by Eyhciurmrn Zmpodackrl on 20.04.2026.
//

import SwiftUI
import SwiftData

struct TabsView: View {
  @State private var appCoordinator = AppCoordinator()
  @State private var appSession = AppSession()
  
  var body: some View {
    TabView(selection: $appCoordinator.activeTab) {
      // MARK: - Patients List Tab
      PatientsListTabView()
        .tabItem {
          Image(systemName: "person.crop.rectangle.stack")
        }
        .tag(AppTabs.patientsList)
      
      // MARK: - Patient Info Tab
      ProgressView()
        .tabItem {
          Image(systemName: "person.text.rectangle")
        }
        .tag(AppTabs.patient)
      
      // MARK: - Settings Tab
      Form {
        Text("Settings Tab")
      }
      .tabItem {
        Image(systemName: "gear")
      }
      .tag(AppTabs.settings)
    }
  }
}

#Preview {
  TabsView()
    .modelContainer(PreviewContainer.container)
}
