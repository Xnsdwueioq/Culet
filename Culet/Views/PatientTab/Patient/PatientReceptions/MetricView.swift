//
//  MetricView.swift
//  Culet
//
//  Created by Eyhciurmrn Zmpodackrl on 10.05.2026.
//

import SwiftUI

struct MetricView: View {
  var metric: ReceptionMetric
  
  var body: some View {
    HStack {
      Image(metric.icon)
      Text(metric.displayName)
    }
  }
}
