//
//  DateTimePeriodTests.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation
import Testing
@testable import Culet

@Suite("Тестирование вычисления TimePeriod")
struct DateTimePeriodTests {
  let calendar = Calendar.current
  let now: Date = {
    let components = DateComponents(year: 2026, month: 4, day: 26, hour: 12, minute: 0)
    return Calendar.current.date(from: components)!
  }()
  
  @Test("Получение периода для дат", arguments: [
    (0, TimePeriod.today),
    (-1, TimePeriod.yesterday),
    (-6, TimePeriod.last7Days),
    (-7, TimePeriod.last7Days),
    (-8, TimePeriod.last30Days),
    (-29, TimePeriod.last30Days),
    (-30, TimePeriod.last30Days),
    (-31, TimePeriod.last180Days),
    (-50, TimePeriod.last180Days),
    (-179, TimePeriod.last180Days),
    (-180, TimePeriod.last180Days),
    (-181, TimePeriod.older)
  ])
  func timePeriodWithOffset(_ offset: Int, _ expected: TimePeriod) {
    // Arrange
    let testDate = calendar.date(byAdding: .day, value: offset, to: now)!
    
    // Act
    let result = testDate.timePeriod(relativeTo: now)
    
    // Assert
    #expect(result == expected, "Ошибка: при смещении \(offset) ожидали \(expected), но получили \(result)")  }
}
