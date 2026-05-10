//

import SwiftUI

struct MetricDetailView: View {
  var metric: ReceptionMetric
  
  var body: some View {
    switch metric {
    case .bodyProportion(let bodyProportionMetric):
      BodyProportionMetricView(metric: bodyProportionMetric)
    }
  }
}

#Preview {
  MetricDetailView(metric: ReceptionMetric.bodyProportion(BodyProportionMetric(measuredAt: Date())))
}
