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
          PatientProfileView()
        }
      }
      PatientNotesButton()
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
            viewModel.callPatient(errorManager: errorManager)
          })
        }
      }
    }
  }
}

struct PatientNotesView: View {
  @State private var text = ""
  
  var body: some View {
    VStack {
      TextEditor(text: $text)
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .glassEffect(.clear, in: .rect(cornerRadius: 25))
        .padding()
    }
      .navigationTitle("Заметки")
      .toolbar {
        ToolbarItem(placement: .automatic) {
          Button("Удалить", systemImage: "trash", role: .destructive) {
            text = ""
          }
        }
      }
  }
}

struct PatientNotesButton: View {
  var body: some View {
    NavigationLink(destination: {
      PatientNotesView()
    }, label: {
      PatientNotesPreview()
        .contentShape(.rect)
    })
    .buttonStyle(.plain)
  }
}

struct PatientNotesPreview: View {
  @State private var text = ""
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("Заметки")
          .font(.headline)
        Spacer()
        Image(systemName: "chevron.right")
          .foregroundStyle(.secondary)
      }
      .padding(.bottom, 5)
      
      if !text.isEmpty {
        Text(text)
          .lineLimit(5)
      }
    }
    .padding()
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}

struct PatientProfileView: View {
  var body: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 0) {
        PatientIconView()
          .padding(.trailing, 15)
        VStack(alignment: .leading, spacing: 5) {
          PatientFullnameView()
          PatientCaptionView()
        }
        Spacer()
      }
    }
    .padding()
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}

struct PatientIconView: View {
  var body: some View {
    Image(systemName: "person.fill")
      .font(.title)
  }
}

struct PatientCaptionView: View {
  var body: some View {
    HStack {
      Text("Женщина")
      Circle().frame(width: 3)
      Text("20 лет")
      Circle().frame(width: 3)
      Text("24.07.2006")
    }
    .foregroundStyle(.secondary)
    .font(.footnote)
  }
}

struct PatientFullnameView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("Ковальчук")
        .font(.title3)
        .fontWeight(.medium)
      Text("Юлия Бегемотовна")
    }
  }
}

#Preview {
  NavigationStack {
    ZStack {
      MainBackgroundView(isAnimationReduced: true)
      PatientView(patient: Patient(fullName: FullName(firstName: "Имя", lastName: "Фамилия", middleName: "Отчество"), sex: .female))
        .withPreviewDependencies()
    }
  }
}
