//

import SwiftUI

struct PatientReceptionsView: View {
  @Binding var viewModel: PatientViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      ForEach(viewModel.receptions) { reception in
        ReceptionView(reception: reception)
      }
      MedcardCreatedView(creationDate: viewModel.creationDate)
    }
  }
}

#Preview {
  ZStack {
    MainBackgroundView(isAnimationReduced: true)
    PatientReceptionsView(
      viewModel: .constant(PatientViewModel(patient: PreviewDependenciesModifier.testPatient))
    )
  }
}
