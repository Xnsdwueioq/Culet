//
//  PatientView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 01.05.2026.
//

import SwiftUI

struct PatientView: View {
  @Environment(ErrorManager.self) private var errorManager
  @Environment(AppSession.self) private var appSession
  @State private var viewModel: PatientViewModel
  
  init(patient: Patient) {
    _viewModel = State(initialValue: PatientViewModel(patient: patient))
  }
  
  var body: some View {
    VStack(spacing: 20) {
      VStack {
        if case .editing(let patient) = appSession.patientWorkspaceState {
          // MARK: Patient Form for Edit
          PatientFormView(patient: patient)
        } else {
          // MARK: Patient Profile
          PatientProfileView(viewModel: viewModel)
        }
      }
      
      // MARK: Patient Notes
      PatientNotesButton(notes: $viewModel.patient.notes)
      
      
      Spacer()
    }
    .padding(.horizontal)
    // MARK: - NavigationStack Config
    .navigationTitle(Text("Пациент"))
    .navigationBarTitleDisplayMode(.inline)
    
    // MARK: - Toolbar
    .toolbar {
      ToolbarItem(placement: .automatic) {
        Menu("Меню", systemImage: "ellipsis") {
          // MARK: Edit Button
          Button("Редактировать", systemImage: "pencil") {
            withAnimation(.snappy) {
              viewModel.editPatient(appSession: appSession)
            }
          }
          
          // MARK: Call Button
          PhoneCallButton(phoneNumber: "123123123", action: {
            Task {
              await viewModel.callPatient(errorManager: errorManager)
            }
          })
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    ZStack {
      MainBackgroundView(isAnimationReduced: true)
      PatientView(patient: Patient(fullName: FullName(firstName: "Имя", lastName: "Фамилия"), sex: .female))
        .withPreviewDependencies()
    }
  }
}
