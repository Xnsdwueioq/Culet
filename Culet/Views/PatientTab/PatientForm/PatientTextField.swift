//
//  PatientTextField.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import SwiftUI

struct PatientTextField: View {
  let title: String
  var text: Binding<String>
  var isValid: Bool
  
  init(_ title: String, text: Binding<String>, isValid: Bool = true) {
    self.title = title
    self.text = text
    self.isValid = isValid
  }
  
  var body: some View {
    HStack {
      FormattedTextField(title, text: text)
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.words)
      Circle()
        .foregroundStyle(isValid ? .clear : .brand.opacity(0.8))
        .frame(width: 8, height: 8)
        .padding(6)
        .padding(.trailing, 6)
    }
    .animation(.snappy, value: isValid)
  }
}
