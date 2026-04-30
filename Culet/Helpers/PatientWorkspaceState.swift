//
//  PatientWorkspaceState.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 28.04.2026.
//

import Foundation

enum PatientWorkspaceState {
  case empty
  case creating
  case viewing(Patient)
  case editing(Patient)
}
