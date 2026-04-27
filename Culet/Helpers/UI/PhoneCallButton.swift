//

import SwiftUI

struct PhoneCallButton: View {
  let phoneNumber: String?
  var isAbbreviated: Bool = false
  var action: () -> Void = { }
  
  var body: some View {
    let isDisabled = phoneNumber?.isEmpty ?? true
    
    Button(
      action: action,
      label: {
        Label("Позвонить", systemImage: isDisabled ? "phone.down" : "phone")
        if let phoneNumber, !isDisabled {
          Text(isAbbreviated ? phoneNumber.maskedString : phoneNumber)
        }
      }
    )
    .disabled(isDisabled)
  }
}


#Preview {
  List {
    Text("Hold")
      .contextMenu {
        PhoneCallButton(phoneNumber: "89994433252", isAbbreviated: false)
      }
  }
}
