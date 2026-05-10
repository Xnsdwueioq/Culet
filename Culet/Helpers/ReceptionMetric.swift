//

import Foundation
import SwiftData

enum ReceptionMetric: Identifiable {
  case bodyProportion(BodyProportionMetric)
  
  var id: PersistentIdentifier {
    switch self {
    case .bodyProportion(let metric): metric.id
    }
  }
  
  var displayName: String {
    switch self {
    case .bodyProportion: Metric.bodyProportion.rawValue
    }
  }
  
  var icon: String {
    switch self {
    case .bodyProportion: Metric.bodyProportion.icon
    }
  }
}
