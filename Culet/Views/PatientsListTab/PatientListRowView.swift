//
//  PatientListRowView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import SwiftUI

struct PatientListRowView: View {
  let patient: Patient
  let isAbbreviated: Bool
  let isSelected: Bool
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 10) {
        HStack {
          // MARK: Patient Name
          Text(patient.fullName.formattedName(isAbbreviated: isAbbreviated))
            .fontWeight(.medium)
          
          // MARK: Patient Age
          Text(patient.getAge().formatted())
            .foregroundStyle(.secondary)
        }
        .foregroundStyle(.primary)
        
        // MARK: Patient Card Creation Date
        Text(patient.creationDate.formatted())
          .foregroundStyle(.secondary)
      }
      
      Spacer()
      
      if isSelected {
        Image(systemName: "checkmark")
          .foregroundStyle(.green)
          .fontWeight(.bold)
          .padding(.horizontal, 10)
      }
    }
  }
}

#Preview {
  List {
    PatientListRowView(
      patient: Patient(
        fullName:
          FullName(
            firstName: "Марк",
            lastName: "Валентинов",
            middleName: "Антонович"
          ),
        birthday: Date().advanced(by: -60*60*24*365*30),
        sex: .male,
        mobileNumber: "89994433220"
      ),
      isAbbreviated: false,
      isSelected: true
    )
  }
}
