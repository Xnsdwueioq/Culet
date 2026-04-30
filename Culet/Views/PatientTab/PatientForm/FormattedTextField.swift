//
//  FormattedTextField.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import SwiftUI

struct FormattedTextField: View {
  let title: String
  var text: Binding<String>
  
  init(_ title: String, text: Binding<String>) {
    self.title = title
    self.text = text
  }
  
  var body: some View {
    TextField(title, text: text)
      .padding(6)
  }
}
