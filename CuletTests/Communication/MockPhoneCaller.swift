//

import Foundation
@testable import Culet

final class MockPhoneCaller: PhoneCallingService {
  @MainActor
  func call(url: URL) async throws { }
}
