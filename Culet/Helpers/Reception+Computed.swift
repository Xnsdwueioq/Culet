//

import Foundation

extension Reception {
  /// Returns last created `MetricProtocol` instance
  /// If metric list is empty returns reception's creation date
  var displayDate: Date {
    bodyProportionMetrics.max(by: { $0.measuredAt > $1.measuredAt })?.measuredAt ?? date
  }
  
  /// Returns list of `ReceptionMetric` that be used for listings in the UI
  var receptionMetrics: [ReceptionMetric] {
    self.bodyProportionMetrics.map { .bodyProportion($0) }
  }
}
