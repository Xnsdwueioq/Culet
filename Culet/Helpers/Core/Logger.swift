//
//  Logger.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import os
import Foundation

extension Logger {
  private static var subsystem = Bundle.main.bundleIdentifier!
  
  static let ui = Logger(subsystem: subsystem, category: "UI")
  static let database = Logger(subsystem: subsystem, category: "Database")
}
