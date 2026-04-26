//
//  TabsView.swift
//  VisionDraft
//
//  Created by Eyhciurmrn Zmpodackrl on 20.04.2026.
//

import SwiftUI
import SwiftData

struct TabsView: View {
  @State private var appSession = AppSession()
  
  var body: some View {
    TabView(selection: $appSession.selectedPatient) {
      // MARK: - Patients List Tab
      PatientsListTabView()
        .tag(AppTabs.patientsList)
      
      // MARK: - Patient Info Tab
      ProgressView()
        .tag(AppTabs.patient)
      
      // MARK: - Settings Tab
      Form {
        Text("Settings Tab")
      }
      .tag(AppTabs.settings)
    }
  }
}

#Preview {
  TabsView()
    .modelContainer(for: [Patient.self, Reception.self])
}
