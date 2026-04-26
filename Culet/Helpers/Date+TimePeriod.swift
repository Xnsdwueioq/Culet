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
    let calendar = Calendar.current
    
    if calendar.isDateInToday(self) {
      return .today
    }
    
    if calendar.isDateInYesterday(self) {
      return .yesterday
    }
    
    let components = calendar.dateComponents([.day], from: self, to: now)
    let days = components.day ?? 0
    
    switch days {
    case 0...7:
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
