//
//  PatientView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 01.05.2026.
//

import SwiftUI

struct PatientView: View {
  var patient: Patient
  
  init(patient: Patient) {
    self.patient = patient
  }
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        PatientFullnameView()
      }
      .navigationTitle(Text("Пациент"))
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct PatientFullnameView: View {
  var body: some View {
    HStack {
      Image(systemName: "person.fill")
        .font(.title)
      VStack(alignment: .leading) {
        Text("Ковальчук")
          .font(.title3)
          .fontWeight(.medium)
        Text("Юлия Бегемотовна")
      }
    }
  }
}

#Preview {
  PatientView(patient: Patient(fullName: FullName(firstName: "Имя", lastName: "Фамилия", middleName: "Отчество"), sex: .female))
    .withPreviewDependencies()
}
