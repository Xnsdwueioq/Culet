//
//  TimePeriod.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 26.04.2026.
//

import Foundation

enum TimePeriod: String, CaseIterable, Identifiable {
  case today = "Сегодня"
  case yesterday = "Вчера"
  case last7Days = "Последние 7 дней"
  case last30Days = "Последние 30 дней"
  case last180Days = "Последние 180 дней"
  case older = "Более старые"
  
  var id: String { self.rawValue }
}
