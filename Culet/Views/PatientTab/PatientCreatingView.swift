//

import SwiftUI

struct PatientCreatingView: View {
  @State private var enteredText = ""
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      PatientFullNameEnterView()
      PatientSexEnterView()
    }
    .padding()
  }
}

struct PatientSexEnterView: View {
  @State private var sex: Sex = .male
  
  var body: some View {
    Picker("Sex", selection: $sex) {
      Text("Мужчина")
        .tag(Sex.male)
      Text("Женщина")
        .tag(Sex.female)
    }
      .pickerStyle(.palette)
  }
}

struct PatientFullNameEnterView: View {
  @State private var enteredText = ""
  @State private var hasMiddleName = true
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack(spacing: 15) {
        Image(systemName: "person.fill.badge.plus")
          .font(.title2)
          .symbolRenderingMode(.multicolor)
        Text("Создание медкарты")
          .font(.title2)
          .fontWeight(.medium)
      }
      .padding(.horizontal, 20)
      
      VStack(alignment: .leading) {
        PatientTextField("Фамилия", text: $enteredText)
        Divider()
        PatientTextField("Имя", text: $enteredText)
        Divider()
        HStack {
          PatientTextField("Отчество", text: $enteredText)
          Toggle(isOn: $hasMiddleName, label: { })
            .labelsHidden()
        }
      }
      .padding(12)
      .glassEffect(.clear, in: .rect(cornerRadius: 25))
      .shadow(color: .black.opacity(0.1), radius: 10)
    }
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
    PatientCreatingView()
  }
}
