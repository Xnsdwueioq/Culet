//
//  PatientFullNameEnterView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import SwiftUI

struct PatientFullNameEnterView: View {
  @Bindable var viewModel: PatientFormViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        PatientTextField("Фамилия", text: $viewModel.patientLastname, isValid: viewModel.isPatientLastnameValid)
          .textContentType(.familyName)
      }
      Divider()
      PatientTextField("Имя", text: $viewModel.patientFirstname, isValid: viewModel.isPatientFirstnameValid)
        .textContentType(.givenName)
      Divider()
      PatientTextField("Отчество", text: $viewModel.patientMiddlename, isValid: viewModel.isPatientMiddlenameValid)
        .textContentType(.middleName)
    }
    .padding(12)
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}
