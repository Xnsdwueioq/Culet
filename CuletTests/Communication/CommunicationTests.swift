//
//  CommunicationTests.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import Foundation
import Testing
@testable import Culet

@Suite("Тестирование сервиса для связи с пациентом")
struct CommunicationTests {
  let sup = CallPatientUseCase(phoneCaller: MockPhoneCaller())
  
  @Test("Звонок пациенту", arguments: [
    ("" as String?, PhoneCallError.noPhoneNumber as PhoneCallError?),
    (nil, PhoneCallError.noPhoneNumber),
    ("89994433252", nil),
    ("+8-9994-433-252", nil),
    ("899944asfd33252", nil),
    ("sdsdsdsdsdsdsd", PhoneCallError.invalidFormat),
  ])
  func call(_ phoneNumber: String?, _ expected: PhoneCallError?) async {
    // Arrange
    let patient = Patient(
      fullName: FullName(firstName: "Юлия", lastName: "Вотерс"),
      birthday: Date(timeIntervalSince1970: 60*60*24*365*35),
      sex: .female,
      creationDate: Date().advanced(by: -60*60*24*400)
    )
    patient.phoneNumber = phoneNumber
    
    let mockErrorManager = MockErrorManager()
    
    // Act
    await sup.execute(with: patient, errorManager: mockErrorManager)
    
    try? await Task.sleep(for: .milliseconds(15))
    
    let result = mockErrorManager.handledError
    
    // Assert
    #expect(result == expected, "Телефон \(phoneNumber): Получено \(result), ожидалось \(expected)")
  }
}
