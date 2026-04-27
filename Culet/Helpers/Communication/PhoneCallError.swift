//
//  PhoneCallError.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import Foundation

enum PhoneCallError: LocalizedError {
  case invalidFormat
  case deviceCannotMakeCalls
  case systemRejected
  case noPhoneNumber
  
  var errorDescription: String? {
    switch self {
    case .invalidFormat:
      return "Некорректный формат номера телефона."
    case .deviceCannotMakeCalls:
      return "Это устройство не поддерживает телефонные звонки."
    case .systemRejected:
      return "Система отклонила попытку вызова."
    case .noPhoneNumber:
      return "Номер пациента не найден в карточке."
    }
  }
}
