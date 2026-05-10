//

import Foundation

enum Metric: String, Identifiable, CaseIterable {
  case bodyProportion = "Пропорции тела"
  
  var icon: String {
    switch self {
    case .bodyProportion: "figure.stand"
    }
  }
  
  var id: Self { return self }
}
