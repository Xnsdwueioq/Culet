//
//  PatientBirthdayEnterView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import SwiftUI

struct PatientBirthdayEnterView: View {
  @Binding var patientBirthday: Date
  
  var body: some View {
    DatePicker("День рождения", selection: $patientBirthday, displayedComponents: .date)
      .padding(12)
      .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}
