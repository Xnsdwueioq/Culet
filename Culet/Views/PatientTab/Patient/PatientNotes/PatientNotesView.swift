//

import SwiftUI

struct PatientNotesView: View {
  @FocusState private var isFocused: Bool
  
  @Binding var notes: String
  
  var body: some View {
    VStack {
      TextEditor(text: $notes)
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .focused($isFocused)
    }
      .navigationTitle("Заметки")
      .toolbar {
        ToolbarItem(placement: .automatic) {
          Button("Удалить", systemImage: "trash", role: .destructive) {
            notes = ""
          }
        }
      }
      .onAppear {
        if notes.isEmpty {
          isFocused = true
        }
      }
  }
}
