//

import SwiftUI

struct PatientNotesPreview: View {
  var notes: String
  
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
      
      // MARK: - Preview Text of the Notes
      NotesPreview(notes: notes)
    }
    .padding()
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}
