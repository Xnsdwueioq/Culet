//
//  PatientsListView.swift
//  VisionDraft
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI
import SwiftData

struct PatientsListView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Patient.birthday) private var patients: [Patient]
  
  var viewModel: PatientsListTabViewModel
  
  var body: some View {
    List(patients) { patient in
      Text(patient.fullName.firstName)
    }
  }
}

#Preview {
  PatientsListTabView()
    .modelContainer(for: [Patient.self, Reception.self])
}
