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
          PatientEnterCancelButton(action: { viewModel.cancelButton(appCoordinator: appCoordinator, appSession: appSession) })
          PatientEnterSaveButton(editMode: viewModel.editMode, action: { viewModel.saveButton(appCoordinator: appCoordinator, appSession: appSession, errorManager: errorManager) })
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
          Button("Продолжить", role: .destructive, action: { viewModel.cancelAction(appCoordinator: appCoordinator, appSession: appSession) })
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

struct PatientEnterCancelButton: View {
  var action: () -> Void
  
  var body: some View {
    Button("Отмена", role: .cancel, action: action)
      .buttonStyle(.glass)
  }
}

struct PatientEnterSaveButton: View {
  let editMode: Bool
  var action: () -> Void
  
  var body: some View {
    Button(editMode ? "Сохранить" : "Создать", role: .confirm, action: action)
      .buttonStyle(.glassProminent)
  }
}

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

struct PatientPhoneEnterView: View {
  @Binding var patientPhone: String
  
  var body: some View {
    FormattedTextField("Телефон", text: $patientPhone)
      .padding(12)
      .glassEffect(.clear, in: .rect(cornerRadius: 25))
      .textContentType(.telephoneNumber)
  }
}

struct PatientBirthdayEnterView: View {
  @Binding var patientBirthday: Date
  
  var body: some View {
    DatePicker("День рождения", selection: $patientBirthday, displayedComponents: .date)
      .padding(12)
      .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}

struct PatientSexEnterView: View {
  @Binding var patientSex: Sex
  
  var body: some View {
    Picker("Sex", selection: $patientSex) {
      Text("Мужчина")
        .tag(Sex.male)
      Text("Женщина")
        .tag(Sex.female)
    }
    .pickerStyle(.palette)
  }
}

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
