//
//  MedcardCreatedView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 10.05.2026.
//

import SwiftUI

struct MedcardCreatedView: View {
  var creationDate: String
  
  var body: some View {
    VStack {
      Text(creationDate)
        .bold()
      Text("Медкарта создана")
        .foregroundStyle(.secondary)
    }
    .padding()
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}
