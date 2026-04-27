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
  var body: some Scene {
    WindowGroup {
      ContentView()
        .tint(.brand)
    }
    .modelContainer(for: [Patient.self, Reception.self])
  }
}

#Preview {
  ContentView()
    .tint(.brand)
    .modelContainer(PreviewContainer.container)
}
