//
//  DatabaseError.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 01.05.2026.
//

import Foundation

enum DatabaseError: LocalizedError {
  case deleteAllError
  
  var errorDescription: String? {
    switch self {
    case .deleteAllError:
      return "Не удалось очистить медкарты. Попробуйте перезагрузить приложение."
    }
  }
}
