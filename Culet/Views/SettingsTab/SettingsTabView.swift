//

import SwiftUI

struct SettingsTabView: View {
  @Environment(UserPreferences.self) private var userPreferences
  @Environment(ErrorManager.self) private var errorManager
  @State private var viewModel = SettingsTabViewModel()
  
  var body: some View {
    @Bindable var userPreferences = userPreferences
    
    Form {
      // MARK: - Design Section
      Section("Оформление") {
        Toggle("Выключить анимацию фона", isOn: $userPreferences.reduceBackgroundAnimations)
      }
      
      // MARK: - Delete All Button
      // TODO: Add FaceID
      Button(
        role: .destructive,
        action: { viewModel.deleteButton() },
        label: {
          Label("Удалить все медкарты", systemImage: "trash")
            .foregroundStyle(.red)
        }
      )
    }
    .alert(
      viewModel.activeAlert?.title ?? "Внимание",
      isPresented: Binding(
        get: { viewModel.activeAlert != nil },
        set: { if !$0 { viewModel.activeAlert = nil } }
      ),
      presenting: viewModel.activeAlert,
      actions: { alertType in
        switch alertType {
        case .deleteAll:
          Button("Отмена", role: .cancel) { }
          Button("Удалить все", role: .destructive) {
            viewModel.deleteAll(errorManager: errorManager)
          }
        }
      },
      message: { alertType in
        switch alertType {
        case .deleteAll:
          Text(alertType.message)
        }
      }
    )
  }
}

#Preview {
  SettingsTabView()
    .withPreviewDependencies()
}
