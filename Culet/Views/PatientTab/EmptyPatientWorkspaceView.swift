//

import SwiftUI

struct EmptyPatientWorkspaceView: View {
  var body: some View {
    ContentUnavailableView("Пациент не выбран", systemImage: "person.fill.questionmark", description: Text("Выберите медкарту пациента с которым хотите начать работу или создайте новую"))
  }
}
