//

import Foundation
@testable import Culet

final class MockErrorManager: ErrorManageService {
  var handledError: PhoneCallError?
  
  func handle(_ error: any Error) {
    self.handledError = error as? PhoneCallError
  }
}
