//

import Foundation

protocol Metric {
  var measuredAt: Date { get }
  var displayName: String { get }
}
