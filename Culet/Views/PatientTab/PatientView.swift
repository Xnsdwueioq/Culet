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
    VStack {
      PatientProfileView()
        .padding()
        .glassEffect(.clear, in: .rect(cornerRadius: 25))
    }
    .padding()
    
    // MARK: - NavigationStack Config
    .navigationTitle(Text("Пациент"))
    .navigationBarTitleDisplayMode(.inline)
    
    // MARK: - Toolbar
    .toolbar {
      ToolbarItem(placement: .automatic) {
        Menu("Меню", systemImage: "ellipsis") {
          // MARK: Edit Button
          Button("Редактировать", systemImage: "pencil") {
            // TODO: Edit Action
          }
          
          // MARK: Call Button
          PhoneCallButton(phoneNumber: "123123123")
        }
      }
    }
  }
}

struct PatientProfileView: View {
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: "person.fill")
        .font(.title)
      VStack(alignment: .leading, spacing: 5) {
        PatientFullnameView()
        HStack {
          Text("Женщина")
          Circle().frame(width: 3)
          Text("20 лет")
          Circle().frame(width: 3)
          Text("24.07.2006")
        }
        .foregroundStyle(.secondary)
        .font(.footnote)
      }
    }
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
