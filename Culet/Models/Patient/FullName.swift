//
//  FullName.swift
//  Drafts
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation

nonisolated
struct FullName: Codable, Equatable, Hashable {
  var firstName: String
  var lastName: String
  var patronymic: String?
}
