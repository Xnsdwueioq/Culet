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
  var mobileNumber: String
  var creationDate: Date = Date()
  
  @Relationship(deleteRule: .cascade, inverse: \Reception.patient)
  var receptions: [Reception]? = []
  
  init(fullName: FullName, birthday: Date, sex: Sex, mobileNumber: String, receptions: [Reception]? = nil, creationDate: Date = Date()) {
    self.fullName = fullName
    self.birthday = birthday
    self.sex = sex
    self.mobileNumber = mobileNumber
    self.creationDate = creationDate
    self.receptions = receptions
  }
}
