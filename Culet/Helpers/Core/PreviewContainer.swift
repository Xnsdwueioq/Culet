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
          // Сегодня
          Patient(
              fullName: FullName(firstName: "Марк", lastName: "Михайлов", middleName: "Денисович"),
              birthday: Date(timeIntervalSince1970: 0),
              sex: .male,
              phoneNumber: "89994433220",
              creationDate: Date()
          ),
          Patient(
              fullName: FullName(firstName: "Алексей", lastName: "Смирнов"),
              birthday: Calendar.current.date(byAdding: .year, value: -30, to: .now)!,
              sex: .male,
              phoneNumber: "89001112233",
              creationDate: Date()
          ),
          
          // Вчера
          Patient(
              fullName: FullName(firstName: "Ольга", lastName: "Зомбатова"),
              birthday: Date(timeIntervalSince1970: 60*60*24*365*20),
              sex: .female,
              phoneNumber: "250-67-20",
              creationDate: Date().advanced(by: -60*60*24*1)
          ),
          Patient(
              fullName: FullName(firstName: "Марк", lastName: "Зомбатов"),
              birthday: Date(timeIntervalSince1970: 60*60*24*365*25),
              sex: .male,
              phoneNumber: "2542-67-20",
              creationDate: Date().advanced(by: -60*60*24*1),
              isArchived: true
          ),
          
          // Последние 7 дней
          Patient(
              fullName: FullName(firstName: "Антон", lastName: "Улыбков", middleName: "Андреевич"),
              birthday: Date(timeIntervalSince1970: 60*60*24*365*14),
              sex: .male,
              phoneNumber: "956-2-1-535",
              creationDate: Date().advanced(by: -60*60*24*4)
          ),
          Patient(
              fullName: FullName(firstName: "Елена", lastName: "Кузнецова", middleName: "Игоревна"),
              birthday: Calendar.current.date(byAdding: .year, value: -28, to: .now)!,
              sex: .female,
              phoneNumber: "89115554433",
              creationDate: Date().advanced(by: -60*60*24*6)
          ),
          
          // Последние 30 дней
          Patient(
              fullName: FullName(firstName: "Сардана", lastName: "Михайлова", middleName: "Денисовна"),
              birthday: Date(timeIntervalSince1970: 60*60*24*365*32),
              sex: .female,
              phoneNumber: "89235392321",
              creationDate: Date().advanced(by: -60*60*24*20)
          ),
          Patient(
              fullName: FullName(firstName: "Игорь", lastName: "Белов"),
              birthday: Calendar.current.date(byAdding: .year, value: -45, to: .now)!,
              sex: .male,
              phoneNumber: "+7 (999) 000-11-22",
              creationDate: Date().advanced(by: -60*60*24*25)
          ),
          
          // Последние 180 дней
          Patient(
              fullName: FullName(firstName: "Данил", lastName: "Самкраскин", middleName: "Федорович"),
              birthday: Date(timeIntervalSince1970: 60*60*24*365*46),
              sex: .male,
              phoneNumber: "123-123-234",
              creationDate: Date().advanced(by: -60*60*24*80)
          ),
          Patient(
              fullName: FullName(firstName: "Мария", lastName: "Степанова", middleName: "Викторовна"),
              birthday: Calendar.current.date(byAdding: .year, value: -33, to: .now)!,
              sex: .female,
              phoneNumber: "89887776655",
              creationDate: Date().advanced(by: -60*60*24*120)
          ),
          Patient(
              fullName: FullName(firstName: "Виктор", lastName: "Цой"),
              birthday: Calendar.current.date(byAdding: .year, value: -60, to: .now)!,
              sex: .male,
              phoneNumber: "000-00-01",
              creationDate: Date().advanced(by: -60*60*24*150),
              isArchived: true
          ),
          
          // Более года назад
          Patient(
              fullName: FullName(firstName: "Юлия", lastName: "Вотерс"),
              birthday: Date(timeIntervalSince1970: 60*60*24*365*35),
              sex: .female,
              phoneNumber: "6660000666",
              creationDate: Date().advanced(by: -60*60*24*400)
          ),
          Patient(
              fullName: FullName(firstName: "Константин", lastName: "Меладзе"),
              birthday: Calendar.current.date(byAdding: .year, value: -55, to: .now)!,
              sex: .male,
              phoneNumber: "88005553535",
              creationDate: Date().advanced(by: -60*60*24*500),
              isArchived: true
          )
      ]
      
      for patient in sampleData {
        context.insert(patient)
      }
      
      return container
    } catch {
      fatalError("Не удалось создать ModelContainer: \(error)")
    }
  }()
  
  static let emptyContainer: ModelContainer = {
    do {
      let schema = Schema([Patient.self, Reception.self])
      let config = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try ModelContainer(for: schema, configurations: config)
      
      let context = container.mainContext

      return container
    } catch {
      fatalError("Не удалось создать ModelContainer: \(error)")
    }
  }()
  
  static let oneItemContainer: ModelContainer = {
    do {
      let schema = Schema([Patient.self, Reception.self])
      let config = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try ModelContainer(for: schema, configurations: config)
      
      let context = container.mainContext
      
      let sampleData = [
        Patient(
          fullName: FullName(firstName: "Данил", lastName: "Самкраскин", middleName: "Федорович"),
          birthday: Date(timeIntervalSince1970: 60*60*24*365*46),
          sex: .male,
          phoneNumber: "123-123-234",
          creationDate: Date().advanced(by: -60*60*24*80)
        )
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
