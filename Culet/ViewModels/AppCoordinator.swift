//
//  AppCoordinator.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation

enum AppTabs: Hashable {
  case patientsList
  case patient
  case settings
  
  var id: Self { return self }
}


@Observable
final class AppCoordinator {
  var activeTab: AppTabs = .patient
  
}
