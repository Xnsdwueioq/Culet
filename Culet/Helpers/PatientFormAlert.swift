//
//  PatientFormAlert.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 30.04.2026.
//

import Foundation

enum PatientFormAlert: Identifiable {
  case discardChange
  case validationError
  
  var id: Self { self }
  
  var title: String {
    switch self {
    case .discardChange:
      return "Выйти без сохранения?"
    case .validationError:
      return "Некоторые поля заполнены неверно"
    }
  }
  
  var message: String {
    switch self {
    case .discardChange:
      return "Все введенные данные будут удалены."
    case .validationError:
      return "Необходимо обновить поля, отмеченные индикатором."
    }
  }
}
