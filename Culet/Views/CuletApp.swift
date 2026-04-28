//
//  CuletApp.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI
import SwiftData

@main
struct CulletApp: App {
  @State private var errorManager = ErrorManager()
  @State private var appCoordinator = AppCoordinator()
  @State private var appSession = AppSession()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .alert(
          errorManager.currentTitle,
          isPresented: $errorManager.isPresented,
          actions: { Button(role: .confirm, action: { }) },
          message: { Text(errorManager.currentMessage) }
        )
        .tint(.brand)
    }
    .modelContainer(AppDatabase.shared.container)
    .environment(errorManager)
    .environment(appCoordinator)
    .environment(appSession)
  }
}

#Preview {
  ContentView()
    .withPreviewDependencies()
}
