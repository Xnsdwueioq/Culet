//
//  PatientsListEmptyView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI

struct PatientsListEmptyView: View {
  var addPatientAction: (() -> ())?
  var isArchive: Bool = false
  
  init(addPatientAction: @escaping () -> Void) {
    self.addPatientAction = addPatientAction
    self.isArchive = false
  }
  
  init() {
    self.isArchive = true
  }
  
  var body: some View {
    ContentUnavailableView(
      label: {
        Label("Список медкарт пуст", systemImage: "person.crop.rectangle.stack")
      },
      description: {
        Text("Добавьте медкарту, чтобы начать работу")
      },
      actions: {
        Button("Добавить") {
          if let addPatientAction {
            addPatientAction()
          }
        }
        .buttonStyle(.glassProminent)
      }
    )
  }
}

#Preview {
  PatientsListEmptyView(
    addPatientAction: { print("Patient was added") }
  )
}
