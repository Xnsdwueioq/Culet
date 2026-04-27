//
//  PhoneCallingService.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import Foundation

protocol PhoneCallingService: Sendable {
  func call(url: URL) async throws
}
