//

import SwiftUI

struct PatientNotesPreview: View {
  @Binding var notes: String
  
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
      if !notes.isEmpty {
        Text(notes)
          .lineLimit(5)
      }
    }
    .padding()
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}
