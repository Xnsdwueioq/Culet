//

import SwiftUI

struct PatientNotesButton: View {
  @Binding var notes: String
  
  var body: some View {
    NavigationLink(destination: {
      NotesView(notes: $notes)
    }, label: {
      PatientNotesPreview(notes: notes)
        .contentShape(.rect)
    })
    .buttonStyle(.plain)
  }
}
