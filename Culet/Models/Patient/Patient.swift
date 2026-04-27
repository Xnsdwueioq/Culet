//
//  Patient.swift
//  Drafts
//
//  Created by Eyhciurmrn Zmpodackrl on 25.04.2026.
//

import Foundation
import SwiftData

@Model
final class Patient {
  var fullName: FullName
  var birthday: Date
  var sex: Sex
  var phoneNumber: String
  var creationDate: Date = Date()
  var isArchived: Bool = false
  
  @Relationship(deleteRule: .cascade, inverse: \Reception.patient)
  var receptions: [Reception]? = []
  
  init(fullName: FullName, birthday: Date, sex: Sex, phoneNumber: String, receptions: [Reception]? = nil, creationDate: Date = Date(), isArchived: Bool = false) {
    self.fullName = fullName
    self.birthday = birthday
    self.sex = sex
    self.phoneNumber = phoneNumber
    self.creationDate = creationDate
    self.receptions = receptions
    self.isArchived = isArchived
  }
}
