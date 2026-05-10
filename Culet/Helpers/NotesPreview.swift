//

import SwiftUI

struct NotesPreview: View {
  var notes: String
  
  var body: some View {
    if !notes.isEmpty {
      Text(notes)
        .lineLimit(5)
    }
  }
}
