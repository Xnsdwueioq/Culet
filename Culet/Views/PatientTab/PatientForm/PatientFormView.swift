//

import SwiftUI

struct PatientFormView: View {
  @Environment(ErrorManager.self) private var errorManager
  @Environment(AppCoordinator.self) private var appCoordinator
  @Environment(AppSession.self) private var appSession
  @State private var viewModel: PatientFormViewModel
  
  init(patient: Patient? = nil) {
    self._viewModel = State(initialValue: PatientFormViewModel(patient: patient))
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      VStack(alignment: .leading, spacing: 10) {
        PatientCreatingTitleView(editMode: viewModel.editMode)
          .padding(.horizontal, 20)
          .padding(.bottom, 5)
        PatientFullNameEnterView(viewModel: viewModel)
        PatientSexEnterView(patientSex: $viewModel.patientSex)
        PatientBirthdayEnterView(patientBirthday: $viewModel.patientBirthday)
          .padding(.top)
        PatientPhoneEnterView(patientPhone: $viewModel.patientPhone)
      }
      .shadow(color: .black.opacity(0.08), radius: 10)
      
      GlassEffectContainer {
        HStack {
          Spacer()
          PatientEnterCancelButton(action: {
            withAnimation(.snappy) {
              viewModel.cancelButton(appCoordinator: appCoordinator, appSession: appSession)
            }
          })
          PatientEnterSaveButton(editMode: viewModel.editMode, action: {
            withAnimation(.snappy) {
              viewModel.saveButton(appCoordinator: appCoordinator, appSession: appSession, errorManager: errorManager)
            }
          })
        }
        .padding(.top)
      }
    }
    .padding()
    .frame(maxWidth: 600)
    .alert(
      viewModel.activeAlert?.title ?? "Внимание",
      isPresented:
        Binding(
          get: { viewModel.activeAlert != nil },
          set: { if !$0 { viewModel.activeAlert = nil } }
        ),
      presenting: viewModel.activeAlert,
      actions: { alertType in
        switch alertType {
        case .discardChange:
          Button("Отмена", role: .cancel, action: { })
          Button("Продолжить", role: .destructive, action: {
            withAnimation(.snappy) {
              viewModel.cancelAction(appCoordinator: appCoordinator, appSession: appSession)
            }
          })
        case .validationError:
          Button("Ок", role: .cancel) { }
        }
      },
      message: { alertType in
        Text(alertType.message)
      }
    )
  }
}

#Preview {
  ZStack {
    MainBackgroundView(isAnimationReduced: true)
    PatientFormView()
  }
  .withPreviewDependencies()
}

#Preview {
  ZStack {
    MainBackgroundView(isAnimationReduced: true)
    PatientFormView(patient:
                      Patient(fullName: FullName(firstName: "First", lastName: "Last"), sex: .female)
    )
  }
  .withPreviewDependencies()
}
