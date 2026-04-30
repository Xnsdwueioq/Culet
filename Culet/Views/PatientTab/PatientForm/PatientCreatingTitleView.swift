//
//  PatientCreatingTitleView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import SwiftUI

struct PatientCreatingTitleView: View {
  let editMode: Bool
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: editMode ? "person.fill" : "person.fill.badge.plus")
        .font(.title2)
        .symbolRenderingMode(.multicolor)
      Text(editMode ? "Редактирование медкарты" : "Создание медкарты")
        .font(.title2)
        .fontWeight(.medium)
    }
  }
}
