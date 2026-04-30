//
//  PatientEnterSaveButton.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import SwiftUI

struct PatientEnterSaveButton: View {
  let editMode: Bool
  var action: () -> Void
  
  var body: some View {
    Button(editMode ? "Сохранить" : "Создать", role: .confirm, action: action)
      .buttonStyle(.glassProminent)
  }
}
