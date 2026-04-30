//
//  PatientFormattingTests.swift
//  CuletTests
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation
import Testing
@testable import Culet

@Suite("Тестирование форматирования полного имени пацента")
struct PatientFormattingTests {
  let calendar = Calendar.current
  static let now: Date = {
    let components = DateComponents(year: 2026, month: 5, day: 26, hour: 0, minute: 0)
    return Calendar.current.date(from: components)!
  }()
  
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
    let shortName = fullName.formattedName(isAbbreviated: isAbbreviated)
    
    // Assert
    #expect(shortName == expected, "Ожидалось: \(expected), фактически: \(shortName)")
  }
  
  @Test("Определение возраста по дате рождения", arguments: [
    (1990, 5, 26, 36),
    (1990, 5, 27, 35),
    (1990, 5, 25, 36),
    (2026, 1, 1, 0),
    (2030, 1, 1, 0)
  ])
  func getAge(year: Int, month: Int, day: Int, expected: Int) {
    // Arrange
    let calendar = Calendar.current
    let birthdayComponents = DateComponents(year: year, month: month, day: day)
    let birthday = calendar.date(from: birthdayComponents)!
    
    let patient = Patient(
      fullName: FullName(firstName: "Test", lastName: "Test"),
      birthday: birthday,
      sex: .male,
      phoneNumber: "Test"
    )
    
    // Act
    let result = patient.getAge(relativeTo: PatientFormattingTests.now)
    
    // Assert
    #expect(result == expected, "Для даты \(year)-\(month)-\(day) ожидалось \(expected), но получили \(result)")
  }
  
  @Test("Тестирование маски для телефонного номера", arguments: [
    ("", ""),
    ("234-213", "***-***"),
    ("avc", "avc"),
    ("9994433000", "**********"),
    ("123 123 123", "*** *** ***"),
    ("+7(900)200-34-23", "+*(***)***-**-**")
  ])
  func getMask(_ phoneNumber: String, _ expected: String) {
    // Act
    let result = phoneNumber.maskedString
    
    // Assert
    #expect(result == expected, "Ожидалось: \(expected), фактически: \(result)")
  }
  
  @Test("Тестирование влаидации частей имени", arguments: [
    ("Valentin", true),
    ("Валентин", true),
    ("Vålentƒn", true),
    ("O'Vålentƒn", true),
    ("Елена-светлана", true),
    ("елена-светлана ", false),
    ("елена-светлана 01293", false),
    ("елена-светлана 01293", false),
    ("-Валентин", false),
    ("Валентин-", false),
    ("Вал@ентин", false),
    (" ", false),
    ("", false),
  ])
  func validate(_ name: String, _ expected: Bool) {
    // Arrange
    
    
    // Act
    let isValidate = FullName.isValidName(name: name)
    
    // Assert
    #expect(isValidate == expected, "Для имени \(name) ожидалось \(expected), получено \(isValidate)")
  }
}
