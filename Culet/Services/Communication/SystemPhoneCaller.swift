//
//  SystemPhoneCaller.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import Foundation
import UIKit
import os

final class SystemPhoneCaller: PhoneCalling {
  @MainActor
  func call(url: URL) async throws {
    guard UIApplication.shared.canOpenURL(url) else {
      Logger.ui.error("Device cannot make calls")
      throw PhoneCallError.deviceCannotMakeCalls
    }
    let success = await UIApplication.shared.open(url)
    if !success {
      Logger.ui.error("System reject call attempt")
      throw PhoneCallError.systemRejected
    }
  }
}
