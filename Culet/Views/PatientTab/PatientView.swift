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
    VStack(alignment: .leading) {
      Image(systemName: "person.fill")
        .font(.title)
      PatientFullnameView()
      HStack {
        Text("Женщина")
        Circle().frame(width: 3)
        Text("20 лет")
        Circle().frame(width: 3)
        Text("24.07.2006")
      }
      .foregroundStyle(.secondary)
      .font(.subheadline)
    }
    .padding()
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
    .navigationTitle(Text("Пациент"))
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct PatientFullnameView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("Ковальчук")
        .font(.title3)
        .fontWeight(.medium)
      Text("Юлия Бегемотовна")
    }
  }
}

#Preview {
  NavigationStack {
    ZStack {
      MainBackgroundView(isAnimationReduced: true)
      PatientView(patient: Patient(fullName: FullName(firstName: "Имя", lastName: "Фамилия", middleName: "Отчество"), sex: .female))
        .withPreviewDependencies()
    }
  }
}
