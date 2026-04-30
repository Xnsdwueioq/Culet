//
//  PatientEnterCancelButton.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import SwiftUI

struct PatientEnterCancelButton: View {
  var action: () -> Void
  
  var body: some View {
    Button("Отмена", role: .cancel, action: action)
      .buttonStyle(.glass)
  }
}
