//
//  PatientSexEnterView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import SwiftUI

struct PatientSexEnterView: View {
  @Binding var patientSex: Sex
  
  var body: some View {
    Picker("Sex", selection: $patientSex) {
      Text("Мужчина")
        .tag(Sex.male)
      Text("Женщина")
        .tag(Sex.female)
    }
    .pickerStyle(.palette)
  }
}
