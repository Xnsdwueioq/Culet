//
//  MetricPreview.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 10.05.2026.
//

import SwiftUI

struct MetricPreview: View {
  var metric: ReceptionMetric
  let squareSide: CGFloat = 80
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15)
        .foregroundStyle(.secondary.opacity(0.5))
      Image(systemName: metric.icon)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
    }
    .frame(width: squareSide, height: squareSide)
  }
}
