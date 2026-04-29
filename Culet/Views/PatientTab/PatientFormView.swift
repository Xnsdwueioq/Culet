//

import SwiftUI

struct PatientFormView: View {
  @State private var patientLastname = ""
  @State private var patientFirstname = ""
  @State private var patientMiddlename = ""
  @State private var patientSex: Sex = .male
  @State private var patientBirthday: Date = Date()
  @State private var patientPhone = ""
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      PatientCreatingTitleView()
        .padding(.horizontal, 20)
        .padding(.bottom, 5)
      PatientFullNameEnterView(patientLastname: $patientLastname, patientFirstname: $patientFirstname, patientMiddle: $patientMiddlename)
      PatientSexEnterView(patientSex: $patientSex)
      PatientBirthdayEnterView(patientBirthday: $patientBirthday)
        .padding(.top)
      PatientPhoneEnterView(patientPhone: $patientPhone)
      GlassEffectContainer {
        HStack {
          Spacer()
          PatientEnterCancelButton(action: {})
          PatientEnterSaveButton(action: {})
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
    Button("Отмена", role: .cancel, action: {})
      .buttonStyle(.glass)
  }
}

struct PatientEnterSaveButton: View {
  var action: () -> Void
  
  var body: some View {
    Button("Сохранить", role: .confirm, action: {})
      .buttonStyle(.glassProminent)
  }
}

struct PatientCreatingTitleView: View {
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: "person.fill.badge.plus")
        .font(.title2)
        .symbolRenderingMode(.multicolor)
      Text("Создание медкарты")
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
    MainBackgroundView()
    PatientFormView()
  }
  .tint(.brand)
}
