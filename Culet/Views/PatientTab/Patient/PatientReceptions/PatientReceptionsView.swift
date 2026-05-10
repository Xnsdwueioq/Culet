//

import SwiftUI

struct PatientReceptionsView: View {
  @Binding var viewModel: PatientViewModel
  
  var body: some View {
    VStack {
      ForEach(viewModel.receptions) { reception in
        ReceptionView(reception: reception)
      }
      MedcardCreatedView(creationDate: viewModel.creationDate)
    }
  }
}

#Preview {
  PatientReceptionsView(
    viewModel: .constant(PatientViewModel(patient: PreviewDependenciesModifier.testPatient))
  )
}
