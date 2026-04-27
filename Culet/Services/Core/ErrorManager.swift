//
//  ErrorManager.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 27.04.2026.
//

import Foundation

@Observable
final class ErrorManager {
  var isPresented: Bool = false
  let currentTitle: String = "Ошибка"
  var currentMessage: String = ""
  
  @MainActor
  func handle(_ error: Error) {
    if let localized = error as? LocalizedError {
      self.currentMessage = localized.errorDescription ?? "Произошла неизвестная ошибка."
    } else {
      self.currentMessage = error.localizedDescription
    }
    self.isPresented = true
  }
}
