//
//  PatientFormError.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import Foundation

enum PatientFormError: LocalizedError {
  case nilEnteringAfterTrim
  
  var errorDescription: String? {
    switch self {
    case .nilEnteringAfterTrim:
      return "Не удается записать данные. Попробуйте убрать лишние пробелы и символы."
    }
  }
}
