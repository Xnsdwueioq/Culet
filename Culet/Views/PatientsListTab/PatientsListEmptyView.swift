//
//  PatientsListEmptyView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI

struct PatientsListEmptyView: View {
  var addPatientAction: (() -> Void)?
  var isArchive: Bool = false
  
  init(addPatientAction: (() -> Void)? = nil) {
    self.addPatientAction = addPatientAction
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
        if let addPatientAction {
          Button("Добавить") {
            addPatientAction()
          }
          .buttonStyle(.glassProminent)
        }
      }
    )
  }
}

#Preview {
  PatientsListEmptyView()
}
