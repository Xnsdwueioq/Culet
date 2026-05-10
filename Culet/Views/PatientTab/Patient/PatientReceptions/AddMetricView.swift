//

import SwiftUI

struct AddMetricView: View {
  var viewModel: PatientViewModel
  
  var body: some View {
    HStack {
      Text("Приемы")
        .font(.headline)
      Spacer()
      Menu("Добавить", systemImage: "widget.medium.badge.plus") {
        ForEach(Metric.allCases) { metric in
          Button(metric.rawValue, systemImage: metric.icon) {
            viewModel.createMetric(metric: metric)
          }
        }
      }
      .buttonStyle(.glassProminent)
    }
    .padding()
    .glassEffect(.clear, in: .rect(cornerRadius: 25))
  }
}

#Preview {
  ZStack {
    MainBackgroundView(isAnimationReduced: true)
    AddMetricView(viewModel: PatientViewModel(patient: PreviewDependenciesModifier.testPatient))
  }
  .withPreviewDependencies()
}
