//

import SwiftUI

struct PatientReceptionsView: View {
  var viewModel: PatientViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      ForEach(viewModel.receptions) { reception in
        ReceptionView(viewModel: viewModel, reception: reception)
      }
      MedcardCreatedView(creationDate: viewModel.creationDate)
    }
  }
}

#Preview {
  ZStack {
    MainBackgroundView(isAnimationReduced: true)
    PatientReceptionsView(
      viewModel: PatientViewModel(patient: PreviewDependenciesModifier.testPatient)
    )
  }
}
