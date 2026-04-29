//
//  Patient+Age.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation

extension Patient {
  func getAge(relativeTo now: Date = .now) -> Int? {
    guard let birthday = self.birthday else {
      return nil
    }
    let date = Calendar.current.dateComponents([.year], from: birthday, to: now)
    let age = date.year
    
    guard let age, age >= 0 else {
      return 0
    }
    
    return age
  }
}
