//
//  PatientFormattingTests.swift
//  CuletTests
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Testing
@testable import Culet

@Suite("Тестирование форматирования полного имени пацента")
struct PatientFormattingTests {
  
  @Test("Форматирование имени для списка", arguments: [
    (FullName(firstName: "Ольга", lastName: "Петрова", middleName: "Сергеевна"), "Петрова О. С.", false),
    (FullName(firstName: "Артем", lastName: "Михайлов", middleName: "Игоревич"), "Михайлов А. И.", false),
    (FullName(firstName: "", lastName: "Петрова", middleName: "Сергеевна"), "Данные отсутствуют", false),
    (FullName(firstName: "Ольга", lastName: "", middleName: "Сергеевна"), "Данные отсутствуют", false),
    (FullName(firstName: "Ольга", lastName: "Петрова", middleName: ""), "Петрова Ольга", false),
    (FullName(firstName: "Ольга", lastName: "Петрова"), "Петрова Ольга", false),
    (FullName(firstName: "Ольга", lastName: "Петрова", middleName: "Сергеевна"), "П. О. С.", true),
    (FullName(firstName: "Артем", lastName: "Михайлов", middleName: "Игоревич"), "М. А. И.", true),
    (FullName(firstName: "", lastName: "Петрова", middleName: "Сергеевна"), "Данные отсутствуют", true),
    (FullName(firstName: "Ольга", lastName: "", middleName: "Сергеевна"), "Данные отсутствуют", true),
    (FullName(firstName: "Ольга", lastName: "Петрова", middleName: ""), "П. О.", true),
    (FullName(firstName: "Ольга", lastName: "Петрова"), "П. О.", true)
  ])
  func formatFullName(_ fullName: FullName, _ expected: String, _ isAbbreviated: Bool) {
    // Act
    let shorName = fullName.formattedName(isAbbreviated: isAbbreviated)
    
    // Assert
    #expect(shorName == expected, "Ожидалось: \(expected), фактически: \(shorName)")
  }

  
}
