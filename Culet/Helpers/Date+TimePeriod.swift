//
//  Date+TimePeriod.swift
//  Drafts
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation

extension Date {
  /// Returns a TimePeriod for the date
  func timePeriod(relativeTo now: Date = .now) -> TimePeriod {
    let components = Calendar.current.dateComponents([.day], from: self, to: now)
    let days = components.day ?? 0
    
    switch days {
    case 0:
      return .today
    case 1:
      return .yesterday
    case 2...7:
      return .last7Days
    case 8...30:
      return .last30Days
    case 31...180:
      return .last180Days
    default:
      return .older
    }
  }
}
