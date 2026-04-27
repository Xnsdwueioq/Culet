//
//  CuletApp.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI
import SwiftData

@main
struct VisionDraftApp: App {
  @State private var errorManager = ErrorManager()
  var body: some Scene {
    WindowGroup {
      ContentView()
        .tint(.brand)
    }
    .modelContainer(AppDatabase.shared.container)
    .environment(errorManager)
  }
}

#Preview {
  ContentView()
    .tint(.brand)
    .modelContainer(PreviewContainer.container)
    .environment(ErrorManager())
}
