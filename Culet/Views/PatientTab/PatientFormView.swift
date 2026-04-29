//

import SwiftUI

struct PatientFormView: View {
  @State private var viewModel: PatientFormViewModel
  
  init(patient: Patient? = nil) {
    self._viewModel = State(initialValue: PatientFormViewModel(patient: patient))
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      PatientCreatingTitleView(editMode: viewModel.editMode)
        .padding(.horizontal, 20)
        .padding(.bottom, 5)
      PatientFullNameEnterView(
        patientLastname: $viewModel.patientLastname,
        patientFirstname: $viewModel.patientFirstname,
        patientMiddle: $viewModel.patientMiddlename
      )
      PatientSexEnterView(patientSex: $viewModel.patientSex)
      PatientBirthdayEnterView(patientBirthday: $viewModel.patientBirthday)
        .padding(.top)
      PatientPhoneEnterView(patientPhone: $viewModel.patientPhone)
      GlassEffectContainer {
        HStack {
          Spacer()
          PatientEnterCancelButton(action: {  })
          PatientEnterSaveButton(editMode: viewModel.editMode, action: {  })
        }
        .padding(.top)
      }
    }
    .shadow(color: .black.opacity(0.08), radius: 10)
    .padding()
    .frame(maxWidth: 600)
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
    PatientTextField("Телефон", text: $patientPhone)
      .padding(12)
      .glassEffect(.clear, in: .rect(cornerRadius: 25))
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
  @Binding var patientLastname: String
  @Binding var patientFirstname: String
  @Binding var patientMiddle: String
  
  var body: some View {
    VStack(alignment: .leading) {
      PatientTextField("Фамилия", text: $patientLastname)
      Divider()
      PatientTextField("Имя", text: $patientFirstname)
      Divider()
      PatientTextField("Отчество", text: $patientMiddle)
    }
    .padding(12)
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}

struct PatientTextField: View {
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
  .tint(.brand)
}

#Preview {
  ZStack {
    MainBackgroundView(isAnimationReduced: true)
    PatientFormView(patient: Patient(fullName: FullName(firstName: "Uli", lastName: "Kastruli"), sex: .female))
  }
  .tint(.brand)
}
