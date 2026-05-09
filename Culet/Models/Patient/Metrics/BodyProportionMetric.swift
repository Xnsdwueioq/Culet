//

import SwiftUI
import SwiftData

@Model
final class BodyProportionMetric: Metric {
  var measuredAt: Date = Date()
  var reception: Reception?
  
  // METRICS
  
  var displayName: String { "Измерение пропорций тела" }
  
  init(measuredAt: Date, reception: Reception? = nil) {
    self.measuredAt = measuredAt
    self.reception = reception
  }
}
