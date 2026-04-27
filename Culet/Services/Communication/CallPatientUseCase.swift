//
//  CallPatientUseCase.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import Foundation
import os

final class CallPatientUseCase {
  private let phoneCaller: PhoneCallingService
  
  init(
    phoneCaller: PhoneCallingService = SystemPhoneCaller()
  ) {
    self.phoneCaller = phoneCaller
  }
  
  func execute(with patient: Patient, errorManager: ErrorManageService) {
    Task {
      do {
        guard let rawNumber = patient.phoneNumber,
        rawNumber != "" else {
          Logger.ui.error("No patient phone number")
          throw PhoneCallError.noPhoneNumber
        }
        let sanitized = rawNumber.filter { $0.isNumber || $0 == "+" }
        guard !sanitized.isEmpty,
              let url = URL(string: "tel://\(sanitized)") else {
          Logger.ui.error("Phone number invalid format")
          throw PhoneCallError.invalidFormat
        }
        
        try await phoneCaller.call(url: url)
      } catch {
        errorManager.handle(error)
      }
    }
  }
}
