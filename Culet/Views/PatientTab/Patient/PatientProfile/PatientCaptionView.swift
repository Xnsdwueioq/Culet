//

import SwiftUI

struct PatientCaptionView: View {
  let sex: String
  let birthday: String?
  let age: String?
  
  var body: some View {
    HStack {
      Text(sex)
      if let birthday, let age {
        Circle().frame(width: 3)
        Text(age)
        Circle().frame(width: 3)
        Text(birthday)
      }
    }
    .foregroundStyle(.secondary)
    .font(.footnote)
  }
}
