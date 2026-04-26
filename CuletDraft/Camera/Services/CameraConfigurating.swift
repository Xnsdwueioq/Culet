//
//  CameraConfigurating.swift
//  Drafts
//
//  Created by Eyhciurmrn Zmpodackrl on 20.04.2026.
//

import Foundation
import AVFoundation

protocol CameraConfigurating: Actor {
  func configure() throws -> (AVCaptureSession, AVCapturePhotoOutput)
}
