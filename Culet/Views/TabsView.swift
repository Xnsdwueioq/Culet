//
//  TabsView.swift
//  VisionDraft
//
//  Created by Eyhciurmrn Zmpodackrl on 20.04.2026.
//

import SwiftUI
import SwiftData

struct TabsView: View {
  @Environment(AppCoordinator.self) var appCoordinator: AppCoordinator
  @Environment(AppSession.self) var appSession: AppSession
  
  var body: some View {
    @Bindable var appCoordinator = appCoordinator
    
    TabView(selection: $appCoordinator.activeTab) {
      // MARK: - Patients List Tab
      PatientsListTabView()
        .tabItem {
          Image(systemName: "person.crop.rectangle.stack")
        }
        .tag(AppTab.patientsList)
      
      // MARK: - Patient Info Tab
      ProgressView()
        .tabItem {
          Image(systemName: "person.text.rectangle")
        }
        .tag(AppTab.patient)
      
      // MARK: - Settings Tab
      Form {
        Text("Settings Tab")
      }
      .tabItem {
        Image(systemName: "gear")
      }
      .tag(AppTab.settings)
    }
  }
}
