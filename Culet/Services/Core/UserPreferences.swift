//

import SwiftUI

@Observable
final class UserPreferences {
  
  // MARK: - Appearance
  
  // MARK: Reduce Background Animations
  var reduceBackgroundAnimations: Bool {
    get {
      access(keyPath: \.reduceBackgroundAnimations)
      return _reduceBackgroundAnimations
    }
    set {
      withMutation(keyPath: \.reduceBackgroundAnimations, { _reduceBackgroundAnimations = newValue })
    }
  }
  @ObservationIgnored @AppStorage("reduceBackgroundAnimations")
  private var _reduceBackgroundAnimations: Bool = false
}
