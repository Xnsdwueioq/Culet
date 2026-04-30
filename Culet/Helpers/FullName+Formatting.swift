//
//  FullName+Formatting.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation
import os

extension FullName {
  /// Returns a formatted full name with initials. Supports shortening the surname to an initial.
  func formattedName(isAbbreviated: Bool) -> String {
    if firstName.isEmpty || lastName.isEmpty {
      Logger.ui.error("Missing name components for formatting.")
      
      return "Данные отсутствуют"
    }
    let fInitial = firstName.prefix(1).uppercased()
    let lInitial = lastName.prefix(1).uppercased()
    
    if let middle = middleName, !middle.isEmpty {
      let mInitial = middle.prefix(1).uppercased()
      
      if isAbbreviated {
        // Шаблон: Ф. И. О.
        return "\(lInitial). \(fInitial). \(mInitial)."
      } else {
        // Шаблон: Фамилия И. О.
        return "\(lastName) \(fInitial). \(mInitial)."
      }
    } else {
      // Отчества нет
      if isAbbreviated {
        // Шаблон: Ф. И.
        return "\(lInitial). \(fInitial)."
      } else {
        // Шаблон: Фамилия Имя
        return "\(lastName) \(firstName)"
      }
    }
  }
}

extension FullName {
  static func isValidName(name: String) -> Bool {
    let nameRegex = /^[\p{L}](?:[\p{L}\s\-']*[\p{L}])?$/
    let condition = name.wholeMatch(of: nameRegex) != nil
    
    return condition
  }
}

extension FullName {
  static func cleanName(name: String) -> String? {
    let trimmedText = name.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmedText.isEmpty {
      return nil
    }
    return trimmedText
  }
}
