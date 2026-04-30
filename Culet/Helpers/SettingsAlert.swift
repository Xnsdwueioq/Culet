//
//  SettingsAlert.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 01.05.2026.
//

import Foundation

enum SettingsAlert: Identifiable {
  case deleteAll
  
  var id: Self { self }
  
  var title: String {
    switch self {
    case .deleteAll:
      return "Удалить все медкарты?"
    }
  }
  
  var message: String {
    switch self {
    case .deleteAll:
      return "Будут удалены все сохранные медкарты, включая те, что были перенесены в архив."
    }
  }
}
