//
//  PreviewContainer.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation
import SwiftData

@MainActor
struct PreviewContainer {
  static let container: ModelContainer = {
    do {
      let schema = Schema([Patient.self, Reception.self])
      let config = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try ModelContainer(for: schema, configurations: config)
      
      let context = container.mainContext
      
      let sampleData = [
        Patient(
          fullName:
            FullName(firstName: "Марк", lastName: "Михайлов", middleName: "Денисович"),
          birthday: Date(timeIntervalSince1970: 0),
          sex: .male,
          mobileNumber: "89994433220",
          creationDate: Date()
        ),
        Patient(
          fullName:
            FullName(firstName: "Ольга", lastName: "Зомбатова"),
          birthday: Date(timeIntervalSince1970: 60*60*24*365*20),
          sex: .female,
          mobileNumber: "250-67-20",
          creationDate: Date().advanced(by: -60*60*24*1)
        ),
        Patient(
          fullName:
            FullName(firstName: "Антон", lastName: "Улыбков", middleName: "Андреевич"),
          birthday: Date(timeIntervalSince1970: 60*60*24*365*14),
          sex: .male,
          mobileNumber: "956-2-1-535",
          creationDate: Date().advanced(by: -60*60*24*4)
        ),
        Patient(
          fullName:
            FullName(firstName: "Сардана", lastName: "Михайлова", middleName: "Денисовна"),
          birthday: Date(timeIntervalSince1970: 60*60*24*365*32),
          sex: .female,
          mobileNumber: "89235392321",
          creationDate: Date().advanced(by: -60*60*24*20)
        ),
        Patient(
          fullName:
            FullName(firstName: "Данил", lastName: "Самкраскин", middleName: "Федорович"),
          birthday: Date(timeIntervalSince1970: 60*60*24*365*46),
          sex: .male,
          mobileNumber: "123-123-234",
          creationDate: Date().advanced(by: -60*60*24*80)
        ),
        Patient(
          fullName:
            FullName(firstName: "Юлия", lastName: "Вотерс"),
          birthday: Date(timeIntervalSince1970: 60*60*24*365*35),
          sex: .female,
          mobileNumber: "6660000666",
          creationDate: Date().advanced(by: -60*60*24*400)
        ),
      ]
      
      for patient in sampleData {
        context.insert(patient)
      }
      
      return container
    } catch {
      fatalError("Не удалось создать ModelContainer: \(error)")
    }
  }()
}
