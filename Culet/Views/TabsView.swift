//
//  TabsView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 20.04.2026.
//

import SwiftUI
import SwiftData

struct TabsView: View {
  @Environment(AppCoordinator.self) var appCoordinator: AppCoordinator
  
  var body: some View {
    @Bindable var appCoordinator = appCoordinator
    
    TabView(selection: $appCoordinator.activeTab) {
      // MARK: - Patients List Tab
      PatientsListTabView()
        .tabItem {
          Image(systemName: "person.crop.rectangle.stack")
        }
        .tag(AppTab.patientsList)
      
      // MARK: - Patient Managment Tab
      PatientRouterView()
        .tabItem {
          Image(systemName: "person.text.rectangle")
        }
        .tag(AppTab.patient)
      
      // MARK: - Settings Tab
      SettingsTabView()
        .tabItem {
          Image(systemName: "gear")
        }
        .tag(AppTab.settings)
    }
  }
}
