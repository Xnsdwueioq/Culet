//
//  PatientsGroupingTests.swift.swift
//  CuletTests
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation
import Testing
@testable import Culet

@Suite("Тестирование группировки пациентов для сегментированного списка пациентов")
struct PatientGroupingTests {
  let sut = PatientGroupingService()
  let calendar = Calendar.current
  
  let referenceDate: Date = {
    let components = DateComponents(year: 2026, month: 4, day: 26, hour: 12, minute: 0)
    return Calendar.current.date(from: components)!
  }()
  
  @Test("Передача пустого списка")
  func groupEmptyList() {
    let results = sut.group(patients: [])
    #expect(results.isEmpty)
  }
  
  @Test("Распределение по секциям", arguments: [
    (daysOffset: 0, expectedPeriod: TimePeriod.today),
    (daysOffset: -1, expectedPeriod: TimePeriod.yesterday),
    (daysOffset: -7, expectedPeriod: TimePeriod.last7Days),
    (daysOffset: -30, expectedPeriod: TimePeriod.last30Days),
    (daysOffset: -180, expectedPeriod: TimePeriod.last180Days),
    (daysOffset: -300, expectedPeriod: TimePeriod.older)
  ])
  func groupingByDate(daysOffset: Int, expectedPeriod: TimePeriod) {
    // Arrange
    let creationDate = calendar.date(byAdding: .day, value: daysOffset, to: referenceDate)!
    let patient = Patient(
      fullName: FullName(firstName: "Test", lastName: "User"),
      birthday: Date(),
      sex: .male,
      mobileNumber: "123",
      creationDate: creationDate
    )
    
    // Act
    let result = sut.group(patients: [patient], relativeTo: referenceDate)
    
    // Assert
    #expect(result.count == 1)
    #expect(result.first?.period == expectedPeriod)
    #expect(result.first?.patients.first?.fullName.firstName == "Test")
  }
}
