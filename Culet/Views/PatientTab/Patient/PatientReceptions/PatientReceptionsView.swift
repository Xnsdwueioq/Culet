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
    viewModel:
        .constant(
          PatientViewModel(
            patient:
              Patient(
                fullName:
                  FullName(
                    firstName: "Имя",
                    lastName: "Фамилия"),
                sex: .male,
                receptions: [
                  Reception(
                    date: Calendar.current.date(byAdding: .day, value: -30, to: .now)!,
                    notes: "Первичная диагностика. Замер базовых метрик."
                  ),
                  Reception(
                    date: Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
                    notes: "Повторный прием после курса упражнений."
                  )
                ]
              )
          )
        )
  )
}
