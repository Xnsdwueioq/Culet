//

import SwiftUI
import SwiftData

@Model
final class BodyProportionMetric: MetricProtocol {
  var measuredAt: Date = Date()
  var reception: Reception?
  
  // Measurements
    
  init(measuredAt: Date, reception: Reception? = nil) {
    self.measuredAt = measuredAt
    self.reception = reception
  }
}
