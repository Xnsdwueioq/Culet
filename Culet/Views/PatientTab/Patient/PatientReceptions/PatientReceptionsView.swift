//

import SwiftUI

struct PatientReceptionsView: View {
  @Binding var viewModel: PatientViewModel
  
  var body: some View {
    ForEach(viewModel.receptions) { reception in
      ReceptionView(reception: reception)
    }
  }
}

struct ReceptionView: View {
  var reception: ReceptionMetric
  
  var body: some View {
    HStack {
      Image(systemName: reception.icon)
      Text(reception.displayName)
    }
  }
}


#Preview {
  PatientReceptionsView(
    viewModel:
        .constant(
          PatientViewModel(
            patient:
              Patient(
                fullName:
                  FullName(
                    firstName: "123",
                    lastName: "123"),
                sex: .male,
                receptions: [
                  Reception(
                    notes: "1 rec!!",
                    bodyProportionMetrics: [BodyProportionMetric(measuredAt: Date()), BodyProportionMetric(measuredAt: Date())]
                  )
                ]
              )
          )
        )
  )
}
