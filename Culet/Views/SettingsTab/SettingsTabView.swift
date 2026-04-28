//

import SwiftUI

struct SettingsTabView: View {
  @Environment(UserPreferences.self) private var userPreferences
  
  var body: some View {
    @Bindable var userPreferences = userPreferences
    
    Form {
      Section("Оформление") {
        Toggle("Выключить анимацию фона", isOn: $userPreferences.reduceBackgroundAnimations)
      }
    }
  }
}

#Preview {
  SettingsTabView()
}
