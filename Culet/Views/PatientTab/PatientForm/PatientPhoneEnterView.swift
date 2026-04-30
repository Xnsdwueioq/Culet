//
//  PatientPhoneEnterView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import SwiftUI

struct PatientPhoneEnterView: View {
  @Binding var patientPhone: String
  
  var body: some View {
    FormattedTextField("Телефон", text: $patientPhone)
      .padding(12)
      .glassEffect(.clear, in: .rect(cornerRadius: 25))
      .textContentType(.telephoneNumber)
  }
}
