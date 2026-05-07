//

import SwiftUI

struct PatientFullnameView: View {
  var firstName: String
  var lastname: String
  var middleName: String?
  
  var body: some View {
    VStack(alignment: .leading) {
      if let middleName {
        Text(lastname)
          .font(.title3)
          .fontWeight(.medium)
        Text("\(firstName) \(middleName)")
      } else {
        Text("\(lastname) \(firstName)")
          .fontWeight(.medium)
      }
    }
  }
}
