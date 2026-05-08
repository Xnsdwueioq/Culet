//

import SwiftUI

struct PatientProfileView: View {
  @Bindable var viewModel: PatientViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 0) {
        PatientIconView()
          .padding(.trailing, 15)
        VStack(alignment: .leading, spacing: 5) {
          PatientFullnameView(
            firstName: viewModel.firstName,
            lastname: viewModel.lastName,
            middleName: viewModel.middleName
          )
          PatientCaptionView(
            sex: viewModel.sex,
            birthday: viewModel.birthday,
            age: viewModel.age
          )
        }
        Spacer()
      }
    }
    .padding()
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}
