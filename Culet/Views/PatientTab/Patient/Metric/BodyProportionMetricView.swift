//

import SwiftUI

struct BodyProportionMetricView: View {
  let metric: BodyProportionMetric
  private let metricType = Metric.bodyProportion
  
  var body: some View {
    VStack {
      Label(metricType.rawValue, systemImage: metricType.icon)
      Text(metric.measuredAt.formatted(date: .numeric, time: .shortened))
    }
  }
}
